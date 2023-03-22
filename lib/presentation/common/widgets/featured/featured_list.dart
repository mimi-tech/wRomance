import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/presentation/common/widgets/book_cover.dart';
import 'package:womanly_mobile/presentation/common/widgets/book_peppers.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured/featured_books.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured_title.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured_title_sceleton.dart';
import 'package:womanly_mobile/presentation/misc/expiration_timer/expiration_timer_settings.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_sceleton.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class FeaturedList extends StatelessWidget {
  final Featured? featured;
  final double itemSize;
  final ScrollController? controller;
  final bool showPeppers;
  final ExpirationTimerSettings expirationTimerSettings;
  const FeaturedList(
    this.featured,
    this.itemSize, {
    this.controller,
    required this.showPeppers,
    this.expirationTimerSettings =
        const ExpirationTimerSettings(alignWithOtherInRow: true),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSceleton = featured == null;
    const groupCount = 2;

    final width = itemSize;
    final height = itemSize +
        (showPeppers ? BookPeppers.height + _hotPeppersMarginTop : 0) +
        (featured?.additionalHeightForExpirationTimer(
                context, expirationTimerSettings) ??
            0);

    final expirationTimerSettingsForAlign = ExpirationTimerSettings(
      style: expirationTimerSettings.style,
      alignWithOtherInRow:
          featured?.hasExpirationTimerForAnyBook(context) ?? false,
    );

    return Column(
      children: [
        const SizedBox(height: 16),
        isSceleton ? const FeaturedTitleSceleton() : _Title(featured!),
        const SizedBox(height: 13),
        SizedBox(
          height: height,
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: isSceleton
                ? 5
                : featured!.books.length < 4
                    ? (featured!.books.length / groupCount).ceil()
                    : null, //(featured!.books.length / groupCount).ceil(),
            itemBuilder: (context, rawIndex) {
              final index = isSceleton
                  ? rawIndex
                  : rawIndex % ((featured!.books.length / groupCount).ceil());
              return isSceleton
                  ? ThemeSceleton(
                      child: Container(
                        margin: FeaturedListItem.margin,
                        width: width,
                        height: height,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(FeaturedListItem.radius)),
                          color: Colors.white,
                        ),
                      ),
                    )
                  : RepaintBoundary(
                      child: Row(children: [
                        for (int i = 0; i < groupCount; i++)
                          (index * groupCount + i < featured!.books.length)
                              ? FeaturedListItem(
                                  width,
                                  height,
                                  featured!.books[index * groupCount + i],
                                  showPeppers: showPeppers,
                                  expirationTimerSettings:
                                      expirationTimerSettingsForAlign,
                                )
                              : const SizedBox.shrink(),
                      ]),
                    );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class FeaturedListItem extends StatelessWidget {
  final double width;
  final double height;
  final Book book;
  final bool showPeppers;
  final ExpirationTimerSettings expirationTimerSettings;
  const FeaturedListItem(
    this.width,
    this.height,
    this.book, {
    required this.showPeppers,
    required this.expirationTimerSettings,
    Key? key,
  }) : super(key: key);

  static const margin = EdgeInsets.symmetric(horizontal: 5);
  static const radius = 11.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BookCover(
            book,
            radius: radius,
            expirationTimerSettings: expirationTimerSettings,
            finishLabelVisible: true,
            // showEmotions: false,
          ),
          if (showPeppers)
            Padding(
              padding: EdgeInsets.only(top: _hotPeppersMarginTop),
              child: BookPeppers(book: book),
            ),
        ],
      ),
    );
  }
}

final _hotPeppersMarginTop = 7.0;

class _Title extends StatelessWidget {
  final Featured featured;
  const _Title(this.featured, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (featured.isFreeMarker) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Image.asset(
              "assets/images/icons/gift.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              featured.title,
              style: ThemeTextStyle.s19w700.copyWith(color: Colors.white),
            ),
          ],
        ),
      );
    }
    return FeaturedTitle(featured.title);
  }
}
