import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final Series? series = context.read<DataRepository>().getSeries(book);
    final indexInSeries = (series?.books.indexOf(book) ?? -2) + 1;

    if (series == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Analytics.logEvent(EventSeriesOpen(series, context));
        Log.dialog(context, "Navigate to the series");
      },
      child: Container(
        color:
        debugColorListenButtonPositions ? Colors.green : Colors.transparent,
        height: height,
        padding: const EdgeInsets.only(bottom: 3),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          text: TextSpan(
            style: ThemeTextStyle.s17w400.copyWith(
              color: ThemeColors.accentBlueTextTabActive,
            ),
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
    );
  }
}