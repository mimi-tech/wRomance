import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/audio_player.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/common/widgets/audio_animation.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_start_sample.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

// Sample Button Style
enum SampleButtonStyle {
  normal,
  tiny,
  newProduct,
  recommendations,
}

class SampleButton extends StatelessWidget {
  final SampleButtonStyle _style;
  final Book book;
  const SampleButton._(this._style, this.book, {Key? key}) : super(key: key);

  factory SampleButton.normal(Book book) =>
      SampleButton._(SampleButtonStyle.normal, book);
  factory SampleButton.tiny(Book book) =>
      SampleButton._(SampleButtonStyle.tiny, book);
  factory SampleButton.newProduct(Book book) =>
      SampleButton._(SampleButtonStyle.newProduct, book);
  factory SampleButton.recommendations(Book book) =>
      SampleButton._(SampleButtonStyle.recommendations, book);

  @override
  Widget build(BuildContext context) {
    final bool isPlayingSample = context.select<AudioPlayer, bool>(
        (player) => player.isPlayingSample && player.sampleBook == book);
    // final bool _newProduct = newProduct &&
    //     context.router.currentSegments.last.args is ProductRouteArgs;

    return GestureDetector(
      onTap: () {
        final audioPlayer = context.read<AudioPlayer>();
        if (audioPlayer.isPlayingSample) {
          audioPlayer.stopSample();
        } else {
          Analytics.logEvent(EventStartSample(
              context, book, context.read<DataRepository>().getSeries(book)));
          audioPlayer.playSample(book);
        }
      },
      child: Container(
        color: Colors.transparent, //essential for tap area
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: _sizeContainer(),
                height: _sizeContainer(),
                decoration: BoxDecoration(
                    color: _colorContainer(), shape: BoxShape.circle),
                child: AudioAnimation(
                  isPlaying: isPlayingSample,
                  size: _sizeAnimation(),
                  style: _style,
                ),
              ),
              if (_style == SampleButtonStyle.normal)
                const SizedBox(
                  height: 8,
                  width: 8,
                ),
              if (_textVisible())
                Text(
                  'Sample',
                  style: ThemeTextStyle.s14w500.copyWith(
                    color: _style == SampleButtonStyle.newProduct
                        ? ThemeColors.accentBlueTextTabActive
                        : Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool _textVisible() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return true;

      case SampleButtonStyle.tiny:
        return false;

      case SampleButtonStyle.newProduct:
        return false;

      case SampleButtonStyle.recommendations:
        return false;
    }
  }

  double _sizeContainer() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return 42;

      case SampleButtonStyle.tiny:
        return 18;

      case SampleButtonStyle.newProduct:
        return 42;

      case SampleButtonStyle.recommendations:
        return 42;
    }
  }

  double _sizeAnimation() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return 24;

      case SampleButtonStyle.tiny:
        return 18;

      case SampleButtonStyle.newProduct:
        return 29;

      case SampleButtonStyle.recommendations:
        return 29;
    }
  }

  Color _colorContainer() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return Colors.transparent;

      case SampleButtonStyle.tiny:
        return Colors.transparent;

      case SampleButtonStyle.newProduct:
        return ThemeColors.accentBackground;

      case SampleButtonStyle.recommendations:
        return ThemeColors.accentBackground.withOpacity(0.5);
    }
  }

  Color _colorIcon() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return Colors.white;

      case SampleButtonStyle.tiny:
        return Colors.white;

      case SampleButtonStyle.newProduct:
        return ThemeColors.accentBlueTextTabActive;

      case SampleButtonStyle.recommendations:
        return ThemeColors.accentBlueTextTabActive;
    }
  }
}
