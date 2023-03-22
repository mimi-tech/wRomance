import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final bool viewAuthor;

  const DescriptionTextWidget(this.text, {this.viewAuthor = false, Key? key})
      : super(key: key);

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf = "";
  String secondHalf = "";
  String _text = "";

  bool flag = true;

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void didUpdateWidget(covariant DescriptionTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _update();
  }

  void _update() {
    if (_text == widget.text) {
      return;
    }
    _text = widget.text;
    final limit = widget.viewAuthor ? 250 : 200;
    if (widget.text.length > limit) {
      firstHalf = widget.text.substring(0, limit);
      secondHalf = widget.text.substring(limit, widget.text.length);
      if (secondHalf.endsWith('\n')) {
        secondHalf = secondHalf.substring(0, secondHalf.length - 1);
      }
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = widget.viewAuthor
        ? ThemeTextStyle.s14w300.copyWith(
            color: const Color(0xB3FFFFFF),
            height: 1.4,
          )
        : ThemeTextStyle.s14w300.copyWith(
            color: const Color(0xB3FFFFFF),
            height: 1.5,
          );

    final _buttonStyle = ThemeTextStyle.s14w500.copyWith(
      color: ThemeColors.accentBlue,
      height: 1.6,
    );

    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 350),
      curve: Curves.decelerate,
      child: SizedBox(
        width: double.infinity,
        child: secondHalf.isEmpty
            ? Text(
                firstHalf,
                style: _textStyle,
                textAlign:
                    widget.viewAuthor ? TextAlign.center : TextAlign.start,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                    child: RichText(
                      textAlign: widget.viewAuthor
                          ? TextAlign.center
                          : TextAlign.start,
                      text: TextSpan(
                        text: flag
                            ? (firstHalf + "...")
                            : (firstHalf + secondHalf),
                        style: _textStyle,
                        children: [
                          TextSpan(
                              text: flag
                                  ? '${widget.viewAuthor ? "\n" : "  "}More'
                                  : '${widget.viewAuthor ? "\n" : "  "}Less',
                              style: _buttonStyle),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
