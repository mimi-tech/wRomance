import 'dart:math';

import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/common/widgets/sample_button.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class AudioAnimation extends StatefulWidget {
  final bool isPlaying;
  final double size;
  final SampleButtonStyle style;
  const AudioAnimation({
    required this.isPlaying,
    this.size = 24,
    this.style = SampleButtonStyle.normal,
    Key? key,
  }) : super(key: key);

  @override
  State<AudioAnimation> createState() => _AudioAnimationState();
}

class _AudioAnimationState extends State<AudioAnimation>
    with SingleTickerProviderStateMixin {
  static final initialHeight = [
    0.2,
    0.5,
    0.8,
    0.4,
    0.6,
    0.3,
  ];
  List<double> heights = List.from(initialHeight);

  late final animation = AnimationController(vsync: this);
  double _lastValue = 0;

  late List<double> steps;

  @override
  void initState() {
    super.initState();
    steps = heights.map((_) => 0.05).toList();
    _reset();
  }

  @override
  void didUpdateWidget(covariant AudioAnimation oldWidget) {
    _reset();
    super.didUpdateWidget(oldWidget);
  }

  void _reset() {
    if (widget.isPlaying) {
      animation.repeat(
          period: const Duration(milliseconds: 1000), reverse: true);
    } else {
      heights = List.from(initialHeight);
      animation.stop();
    }
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          _updateHeights();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                heights.map((it) => _Bar(it, size, widget.style)).toList(),
          );
        },
      ),
    );
  }

  void _updateHeights() {
    final delta = (animation.value - _lastValue).abs() * 20;
    _lastValue = animation.value;

    for (int i = 0; i < heights.length; i++) {
      heights[i] += steps[i] * delta;
      if (heights[i] > 1 || heights[i] < 0) {
        steps[i] = -steps[i];
        heights[i] += steps[i] * delta;
      }
      heights[i] = min(max(heights[i], 0), 1.0);
    }
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final double maxHeight;
  final SampleButtonStyle _style;
  const _Bar(this.height, this.maxHeight, this._style, {Key? key})
      : super(key: key);

  static const double _refSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * maxHeight,
      width: _barWidth() / _refSize * maxHeight,
      margin:
          EdgeInsets.symmetric(horizontal: _barMargin() / _refSize * maxHeight),
      decoration: BoxDecoration(
        color: _barColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  double _barWidth() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return 1.8;

      case SampleButtonStyle.tiny:
        return 1.8;

      case SampleButtonStyle.newProduct:
        return 1.3;

      case SampleButtonStyle.recommendations:
        return 1.3;
    }
  }

  double _barMargin() {
    switch (_style) {
      case SampleButtonStyle.normal:
        return 0.9;

      case SampleButtonStyle.tiny:
        return 0.9;

      case SampleButtonStyle.newProduct:
        return 1.1;

      case SampleButtonStyle.recommendations:
        return 1.1;
    }
  }

  Color _barColor() {
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
