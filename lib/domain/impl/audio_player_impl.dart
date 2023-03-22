import 'dart:async';
import 'dart:math';

import 'package:womanly_mobile/domain/jump_resume_position_listener.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_started_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_t_reactions_listen_started.dart';
import 'package:womanly_mobile/presentation/misc/experiments.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio/just_audio.dart' as just;
import 'package:womanly_mobile/domain/audio_player.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/domain/entities/enums/sleep_timer.dart';
import 'package:womanly_mobile/domain/entities/progress.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/book_statistics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_completed.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_started.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AudioPlayerImpl extends AudioPlayer {
  final _player = just.AudioPlayer();
  final List<StreamSubscription> _streamListeners = [];
  StreamSubscription? _onCurrentIndexChangedSubscription;
  StreamSubscription? _assetListener;
  PlayerState? _playerState;
  Progress? _lastSuccessfulPosition;
  bool _isNetworkConnected = true;
  bool _isAutoPaused = false;

  AudioPlayerImpl(LibraryState state) : super(state) {
    try {
      _initProgress();
      _initSpeed();
      _addStreamListeners();
      _listenForConnectivityChanges();
    } catch (e) {
      Log.print(e);
    }
  }

  void _listenForConnectivityChanges() {
    //NOTE: doesn't work on Android emulator
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      Log.print("==onConnectivityChanged: $result");
      switch (result) {
        case ConnectivityResult.none:
          _isNetworkConnected = false;
          break;
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
          _isNetworkConnected = true;
          if (_isAutoPaused) {
            play();
          }
          break;
        default:
      }
    });
  }

  void _reset() async {
    _isAutoPaused = true;
    NetworkErrorRecognizer.resetAsked();
    await _player.stop();
    try {
      await _player.load();
    } catch (e) {
      Log.print(e); //silent
    }
    final last = _lastSuccessfulPosition;
    if (last != null) {
      await _player.seek(last.position, index: last.chapterIndex);
      final book = state.currentBook;
      if (book != null) {
        state.setBookProgress(book, last);
      }
      if (_isNetworkConnected) {
        play();
      }
    }
  }

  void _initProgress() async {
    final book = state.currentBook;
    if (book != null) {
      final progress = state.getProgress(book);
      await setBook(book, anyway: true);
      setChapter(progress.chapterIndex);
      seekTo(progress.position);
    }
  }

  void _initSpeed() {
    _player.setSpeed(state.playerSpeed.value);
  }

  @override
  bool get isPlaying => _isPlaying;
  bool _isPlaying = false;

  @override
  bool get isBuffering => _isBuffering;
  bool _isBuffering = false;

  @override
  bool get isPlayingSample => _isPlayingSample;
  bool _isPlayingSample = false;
  bool _isPlayingAsset = false;

  @override
  Book? get sampleBook => _sampleBook;
  Book? _sampleBook;

  @override
  Duration get currentPosition => _currentPosition;
  Duration _currentPosition = Duration.zero;

  @override
  Duration get bufferedPosition => _bufferedPosition;
  Duration _bufferedPosition = Duration.zero;

  @override
  Duration get duration => _duration;
  Duration _duration = Duration.zero;

  @override
  bool get isNextEnabled => _player.hasNext;

  @override
  bool get isPrevEnabled => _player.hasPrevious;

  @override
  PlayerSpeed get speed => state.playerSpeed;

  @override
  SleepTimer get timer => _timer;
  SleepTimer _timer = SleepTimer.none;

  @override
  void pause() {
    _isAutoPaused = false;
    _player.pause();
    Log.print("===PAUSE: pause called");

    _isPlaying = false;
    notifyListeners();
  }

  @override
  void play() async {
    BookStatistics.justPressedPlay();
    _isAutoPaused = false;
    _isPlaying = true;
    notifyListeners();

    await stopSample();
    if (_isPlaying) {
      Log.print("===PAUSE: play 1");
      _player.play();
    }
  }

  void _onCurrentIndexChanged(int? value) {
    // no need to do it here, fires on launch several times
    // if (_monetizationState.isSubscriptionRequiredFor(state.currentBook)) {
    //   pause();
    //   return;
    // }

    if (value != null) {
      final book = state.currentBook;
      if (book != null) {
        BookStatistics.setPlaybackPauseReason(
            PlaybackPauseReason.chapter_ended);
        Log.print(
            "===_onCurrentIndexChanged: $value ${BookStatistics.getPlaybackPauseReasonString()}");
        if (isPlaying &&
            !BookStatistics.isJustPressedPlay() &&
            [
              PlaybackPauseReason.chapter_ended,
              PlaybackPauseReason.next_button,
              PlaybackPauseReason.prev_button,
              PlaybackPauseReason.user_selected_chapter,
            ].contains(BookStatistics.playbackPauseReason)) {
          // Analytics.logEvent(
          //     EventListenCompleted(globalNavigatorState.currentContext!, book));
        }
        NetworkErrorRecognizer.currentIndexChanged(
            value, book.chapters.length - 1);
        final chapter =
            value < book.chapters.length ? book.chapters[value] : null;
        if (chapter == null) {
          return; //there is a glitch in audio player when we change sources
        }
        if (!_sampleLock) {
          // Experiments.onCurrentChapterChanged(
          //     globalNavigatorState.currentContext, book, chapter);
        }

        state.setCurrentChapter(value);
        if (!_sampleLock && isPlaying) {
          if (Experiments.resolvePauseMomentOnPlayingChanged(
              state.currentBook)) {
            pause();
            return;
          }
        } else {
          Log.print("===PAUSE: skip");
        }
        if (_player.playing) {
          // Analytics.logEvent(
          //     EventListenStarted(globalNavigatorState.currentContext!, book));
          // if (book.isSharingEmotionsEnabled) {
          //   Analytics.logEvent(EventTReactionsListenStarted(
          //       globalNavigatorState.currentContext!, book));
          // }
        }

        // final progress = state.getProgress(book);
        // state.setBookProgress(
        //     book, Progress(value, Duration.zero)); //TODO: what case?
        _duration = chapter.duration;
        notifyListeners();

        if (NetworkErrorRecognizer.isLikelyNetworkError) {
          _reset();
        }
      }
    }
  }

  void _onStateChangedAsset(just.PlayerState playerState) {
    Log.print("===OSSTATE: ${playerState.processingState}");
    if (_isPlayingAsset &&
        playerState.processingState == just.ProcessingState.completed) {
      stopAsset();
    }
  }

  void _onStateChanged(just.PlayerState playerState) {
    Log.print("===STATE: ${playerState.processingState}");
    _isBuffering = false;
    NetworkErrorRecognizer.stateChanged(playerState.processingState);
    switch (playerState.processingState) {
      // case just.ProcessingState.idle:
      //   break;
      case just.ProcessingState.loading:
        _isBuffering = true;
        break;
      case just.ProcessingState.buffering:
        _isBuffering = true;
        notifyListeners();
        break;
      // case just.ProcessingState.ready:
      //   break;
      case just.ProcessingState.completed:
        pause();
        final book = state.currentBook;
        state.setCurrentBook(null);
        break;
      default:
    }
    notifyListeners();
  }

  void _onIsPlayingChanged(bool value) {
    _isPlaying = value;
    final book = state.currentBook;
    Log.print("===OISP: asset:$_isPlayingAsset value:$value");
    if (book != null) {
      if (value) {
        if (!_sampleLock) {
          if (Experiments.resolvePauseMomentOnPlayingChanged(
              state.currentBook)) {
            pause();
            return;
          }
        }

        // Analytics.logEvent(
        //     EventListenStarted(globalNavigatorState.currentContext!, book));
        // if (book.isSharingEmotionsEnabled) {
        //   Analytics.logEvent(EventTReactionsListenStarted(
        //       globalNavigatorState.currentContext!, book));
        // }
        // Analytics.logEventOnce(
        //     EventListenStartedAF(globalNavigatorState.currentContext!, book),
        //     AnalyticsOnceKey.eventListenStartedAF);
      } else {
        BookStatistics.setPlaybackPauseReason(PlaybackPauseReason.pause_button);
        if ([
          PlaybackPauseReason.pause_button,
          PlaybackPauseReason.call_interrupted,
          PlaybackPauseReason.sleep_timer,
        ].contains(BookStatistics.playbackPauseReason)) {
          // Analytics.logEvent(
          //     EventListenCompleted(globalNavigatorState.currentContext!, book));
        }
      }
    }
    Analytics.sessionManager.onIsPlayingChanged(value);
    BookStatistics.onIsPlayingChanged(value);
    notifyListeners();
    JumpResumePositionListener.onIsPlayingChanged(this, value);
  }

  void _onPositionChanged(Duration position) {
    _currentPosition = position;
    Log.print("===POS: $_currentPosition");
    _updateLastSuccessfulPosition(position);
    state.updateCurrentProgress(position);
    notifyListeners();
    Analytics.sessionManager.onPositionChanged();
  }

  void _updateLastSuccessfulPosition(Duration position) {
    if (_player.playerState.processingState == just.ProcessingState.ready &&
        position.inSeconds > 1) {
      _lastSuccessfulPosition =
          Progress(state.currentChapterIndex ?? 0, position);
    }
  }

  void _onBufferedPositionChanged(Duration position) {
    _bufferedPosition = position;
    Log.print("===BUF: $_bufferedPosition");
    notifyListeners();
  }

  void _onDurationChanged(Duration? value) {
    if (value != null) {
      _duration = value;
      notifyListeners();
    }
  }

  @override
  void seekTo(Duration position) async {
    JumpResumePositionListener.skipNextByUserAction();
    await stopSample();
    Log.print("===SEEK: $position");
    _currentPosition = position;
    _player.seek(position);
  }

  @override
  void jumpBy(Duration offset) async {
    if (offset.inSeconds.abs() == 15) {
      //TODO: ugly
      JumpResumePositionListener.skipNextByUserAction();
    }
    await stopSample();
    int ms = _player.position.inMilliseconds + offset.inMilliseconds;
    final durationMs = _player.duration?.inMilliseconds;
    if (durationMs != null) {
      ms = min(ms, durationMs);
    }
    final newPosition = Duration(milliseconds: max(0, ms));
    _player.seek(newPosition);
  }

  @override
  void nextTrack() async {
    JumpResumePositionListener.skipNextByUserAction();
    NetworkErrorRecognizer.nextTrackPressed();
    await stopSample();
    BookStatistics.setPlaybackPauseReason(PlaybackPauseReason.next_button);
    _player.seekToNext();
  }

  @override
  void prevTrack() async {
    JumpResumePositionListener.skipNextByUserAction();
    NetworkErrorRecognizer.prevTrackPressed();
    await stopSample();
    if (currentPosition.inSeconds < 10) {
      BookStatistics.setPlaybackPauseReason(PlaybackPauseReason.prev_button);
      _player.seekToPrevious();
    } else {
      _player.seek(Duration.zero);
    }
  }

  @override
  Future<void> setBook(Book book, {bool anyway = false}) async {
    await stopSample();
    if (state.currentBook == book && !anyway) {
      return;
    }
    BookStatistics.setPlaybackPauseReason(
        PlaybackPauseReason.user_changed_book);

    // if (isPlaying && book != state.currentBook) {
    //   final currentBook = state.currentBook;
    //   if (currentBook != null) {
    //   Analytics.logEvent(EventListenCompleted(
    //       globalNavigatorState.currentContext!, currentBook));
    //   }
    // }

    _player.pause();

    final progress = state.getProgress(book);
    state.setCurrentBook(book);
    // _removeStreamListeners();
    _onCurrentIndexChangedSubscription?.cancel();
    _streamListeners.remove(_onCurrentIndexChangedSubscription);
    await _player.setAudioSource(
      just.ConcatenatingAudioSource(
        children: book.chapters
            .map(
              (chapter) => just.ProgressiveAudioSource(
                Uri.parse(chapter.trackUrl),
                tag: MediaItem(
                  id: chapter.trackUrl,
                  title: book.name,
                  artUri: Uri.parse(book.coverUrl),
                  displayTitle: book.name,
                  displaySubtitle: chapter.title,
                  // album: "Album DEF",
                  artist: book.author,
                  genre: book.subGenres.first,
                  // duration: Duration(minutes: 1),
                  // displayDescription: "displayDescription",
                ),
              ),
            )
            .toList(),
      ),
      initialIndex: progress.chapterIndex,
      initialPosition: progress.position,
    );
    _streamListeners.add(_onCurrentIndexChangedSubscription =
        _player.currentIndexStream.listen(_onCurrentIndexChanged));
    _player.setSpeed(state.playerSpeed.value);
    // _addStreamListeners();
    notifyListeners();

    // setChapter(progress.chapterIndex);
    // seekTo(progress.position);
  }

  @override
  void setChapter(int index) async {
    NetworkErrorRecognizer.userChangedChapterManually();
    await stopSample();
    _player.seek(Duration.zero, index: index);
    // state.setCurrentChapter(index);

    final book = state.currentBook;
    if (book != null) {
      state.setBookProgress(book, Progress(index, Duration.zero));
    }
  }

  @override
  void changeSpeed() async {
    await stopSample();
    var nextSpeed = speed;
    nextSpeed =
        PlayerSpeed.values[(nextSpeed.index + 1) % PlayerSpeed.values.length];
    _player.setSpeed(nextSpeed.value);
    state.setPlayerSpeed(nextSpeed);
    notifyListeners();
  }

  @override
  void changeTimer() async {
    // await stopSample();
    _timer = SleepTimer.values[(_timer.index + 1) % SleepTimer.values.length];
    //TODO: set timer using alarm manager library (not just a future)
    notifyListeners();
  }

  bool _sampleLock = false;

  @override
  Future<void> stopSample() async {
    if (_sampleLock) {
      return;
    }
    try {
      _sampleLock = true;
      Log.print("==S: stopSample, isPlayingSample: $_isPlayingSample");
      if (!_isPlayingSample) {
        return;
      }
      _isPlayingSample = false;
      _isBuffering = true; //to show that smth is going on
      notifyListeners();
      _player.pause();
      await _restorePlayerState();

      notifyListeners();
    } finally {
      _sampleLock = false;
    }
  }

  @override
  Future<void> stopAsset() async {
    if (_sampleLock) {
      return;
    }
    try {
      _sampleLock = true;
      if (!_isPlayingAsset) {
        return;
      }
      _isPlayingAsset = false;
      _isBuffering = true; //to show that smth is going on
      notifyListeners();
      _player.pause();
      _assetListener?.cancel();
      await _restorePlayerState();

      notifyListeners();
    } finally {
      _sampleLock = false;
    }
  }

  @override
  void playSample(Book book) async {
    if (_sampleLock) {
      return;
    }
    try {
      _sampleLock = true;
      Log.print("==S: playSample");
      _player.pause();
      _persistPlayerState();
      _isPlaying = false;
      _isPlayingSample = true;
      _sampleBook = book;
      notifyListeners();

      await _player.setAudioSource(
        just.ProgressiveAudioSource(
          Uri.parse(book.sampleUrl),
          tag: MediaItem(
            id: book.sampleUrl,
            title: book.name,
            artUri: Uri.parse(book.coverUrl),
            displayTitle: book.name,
            displaySubtitle: "Sample",
            artist: book.author,
            genre: book.subGenres.first,
          ),
        ),
      );

      if (_isPlayingSample) {
        //check added as the state can already be changed
        _player.seek(Duration.zero);
        Log.print("===PAUSE: play 2");

        _player.play();
      }
    } finally {
      _sampleLock = false;
    }
  }

  @override
  void playAsset(Book book) async {
    Log.stub();
  }

  Future<void> _restorePlayerState() async {
    Log.print("==S: _restorePlayerState");

    if (_playerState?.audioSource != null) {
      final state = _playerState!;
      await _player.setAudioSource(state.audioSource!,
          initialIndex: state.currentIndex, initialPosition: state.position);
    } else {
      Log.print("error in _restorePlayerState"); //TODO: throw/fire error
    }

    _addStreamListeners();
  }

  void _persistPlayerState() {
    Log.print("==S: _persistPlayerState");
    _playerState = PlayerState(
      position: _player.position,
      currentIndex: _player.currentIndex,
      audioSource: _player.audioSource,
    );
    _removeStreamListeners();
  }

  void _addStreamListeners() {
    _streamListeners.add(_onCurrentIndexChangedSubscription =
        _player.currentIndexStream.listen(_onCurrentIndexChanged));
    _streamListeners.add(_player.playingStream.listen(_onIsPlayingChanged));
    _streamListeners.add(_player.playerStateStream.listen(_onStateChanged));
    _streamListeners.add(_player.positionStream.listen(_onPositionChanged));
    _streamListeners
        .add(_player.bufferedPositionStream.listen(_onBufferedPositionChanged));
    _streamListeners.add(_player.durationStream.listen(_onDurationChanged));
  }

  void _removeStreamListeners() {
    for (var it in _streamListeners) {
      it.cancel();
    }
    _streamListeners.clear();
  }
}

class PlayerState {
  final Duration position;
  final int? currentIndex;
  final just.AudioSource? audioSource;

  PlayerState({
    required this.position,
    required this.currentIndex,
    required this.audioSource,
  });
}

class NetworkErrorRecognizer {
  static bool get isLikelyNetworkError => _isLikelyNetworkError;
  static bool _isLikelyNetworkError = false;

  static int _lastIndex = 0;
  static just.ProcessingState? _lastState;
  static bool _userInitiated = false;
  static Timer? _userActionTimer;

  static void stateChanged(just.ProcessingState state) {
    _lastState = state;
  }

  static void currentIndexChanged(int index, int max) {
    //Android behaviour
    if (index == _lastIndex + 1 &&
        _lastState == just.ProcessingState.buffering &&
        !_userInitiated) {
      _isLikelyNetworkError = true;
    } else {
      _isLikelyNetworkError = false;
    }

    //iOS behaviour
    if (index == max && _lastIndex + 1 != max && !_userInitiated) {
      _isLikelyNetworkError = true;
    }

    _lastIndex = index;
  }

  static void resetAsked() {
    Log.print("==resetAsked");
    _isLikelyNetworkError = false;
  }

  static void nextTrackPressed() {
    _isLikelyNetworkError = false;
    _userAction();
  }

  static void prevTrackPressed() {
    _isLikelyNetworkError = false;
    _userAction();
  }

  static void userChangedChapterManually() {
    _userAction();
  }

  static void _userAction() {
    _userActionTimer?.cancel();
    _userInitiated = true;
    _userActionTimer = Timer(const Duration(seconds: 1), () {
      _userInitiated = false;
    });
  }
}
