import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_series_open.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/screens/product/product_screen.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class SeriesButton extends StatelessWidget {
  final Book book;
  const SeriesButton(this.book, {Key? key}) : super(key: key);

  static const double height = 32;
  bool _willTextOverflow({required String text, required TextStyle style, required BuildContext  context}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width);

    return textPainter.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    final  maxWidth  = MediaQuery.of(context).size.width;

    final Series? series = context.read<DataRepository>().getSeries(book);
    final indexInSeries = (series?.books.indexOf(book) ?? -2) + 1;
    TextStyle textStyle = ThemeTextStyle.s17w400.copyWith(color: ThemeColors.accentBlueTextTabActive,);


    if (series == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
        onTap: () {
          Analytics.logEvent(EventSeriesOpen(series, context));
          Log.dialog(context, "Navigate to the series");
        },
        child:  Container(
          color: debugColorListenButtonPositions ? Colors.green : Colors.transparent,
          height: height,
          padding: const EdgeInsets.only(bottom: 3),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: Builder(
            builder: (context) {
              if (_willTextOverflow(text: "Series: ${series.title} #$indexInSeries", style: textStyle,context: context)) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),

                  child: SizedBox(
                    height: height,
                    width: maxWidth,
                    child: Center(
                      child: Row(
                        children: [
                          Flexible(
                            child: Marquee(
                              text: "Series: ${series.title} #$indexInSeries",
                              style: textStyle,
                              blankSpace: 12.0,
                              velocity: 30,
                              pauseAfterRound: const Duration(milliseconds: 1500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Image.asset(
                              "assets/images/icons/arrow_right2.png",
                              color: const Color(0xFF648BC6),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: height,
                    width: maxWidth,
                    child: Center(
                      child: RichText(
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textStyle,
                          children: [
                            TextSpan(
                              text: 'Series: ${series.title} #$indexInSeries ',
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Image.asset(
                                  "assets/images/icons/arrow_right2.png",
                                  color: const Color(0xFF648BC6),
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        )

    );
  }
}
