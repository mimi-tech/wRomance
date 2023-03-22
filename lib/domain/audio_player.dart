import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/domain/entities/enums/sleep_timer.dart';
import 'package:womanly_mobile/domain/library_state.dart';

abstract class AudioPlayer extends ChangeNotifier {
  final LibraryState state;

  AudioPlayer(this.state);

  bool get isPlaying;
  bool get isBuffering;
  bool get isPlayingSample;

  ///current (or last) sample audio file is playing(ed) for this book
  Book? get sampleBook;

  Duration get currentPosition;
  Duration get bufferedPosition;
  Duration get duration;
  bool get isPrevEnabled;
  bool get isNextEnabled;
  PlayerSpeed get speed;
  SleepTimer get timer;

  void play();
  void pause();
  void playSample(Book book);
  void stopSample();
  void seekTo(Duration position);
  Future<void> setBook(Book book);
  void setChapter(int index);
  void prevTrack();
  void nextTrack();
  void playAsset(Book book);
  void stopAsset();

  ///offset can be negative, in terms of the current track only
  void jumpBy(Duration offset);

  void changeSpeed();
  void changeTimer();
}
