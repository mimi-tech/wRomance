import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AutoscrollText extends StatefulWidget {
  const AutoscrollText(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.style,
    this.velocity = 15.0,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle? style;
  final double velocity;

  @override
  State<StatefulWidget> createState() => _AutoscrollTextState();
}

class _AutoscrollTextState extends State<AutoscrollText> {
  @override
  Widget build(BuildContext context) {
    final height = (widget.style?.fontSize ?? 16.0) * 1.5;
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final span = TextSpan(text: widget.text, style: widget.style);
          final painter = TextPainter(
            text: span,
            maxLines: 1,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            textDirection: TextDirection.ltr,
          );
          painter.layout();
          final overflow = painter.size.width > constraints.maxWidth;
          if (overflow) {
            return SizedBox(
              child: Marquee(
                startAfter: const Duration(seconds: 1),
                pauseAfterRound: const Duration(seconds: 1),
                text: widget.text,
                crossAxisAlignment: widget.crossAxisAlignment,
                style: widget.style,
                velocity: widget.velocity,
                blankSpace: widget.style?.fontSize ?? 10,
              ),
            );
          } else {
            return ClipRect(
              child: Row(
                mainAxisAlignment: _mainAxisAlignment(),
                children: [
                  Text(
                    widget.text,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    textAlign: widget.textAlign,
                    softWrap: false,
                    style: widget.style,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  MainAxisAlignment _mainAxisAlignment() {
    switch (widget.textAlign) {
      case TextAlign.start:
      case TextAlign.left:
        return MainAxisAlignment.start;
      case TextAlign.end:
      case TextAlign.right:
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.center;
    }
  }
}
