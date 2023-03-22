import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/common/widgets/ios_background_blur.dart';
import 'package:womanly_mobile/presentation/misc/cache/custom_cache_manager.dart';
import 'package:womanly_mobile/presentation/misc/expiration_timer/expiration_timer_settings.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_sceleton.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class BookCover extends StatefulWidget {
  final Book book;
  final double radius;
  final double? radiusTopRight;
  final double? radiusTopLeft;
  final double? radiusBottomRight;
  final double? radiusBottomLeft;
  final bool enableRouting;
  final Function? beforeOnTap;
  final bool showEmotions;
  final bool alwaysShowSkeleton;
  final bool finishLabelVisible;
  final ExpirationTimerSettings expirationTimerSettings;

  const BookCover(
    this.book, {
    required this.radius,
    this.radiusTopRight,
    this.radiusTopLeft,
    this.radiusBottomRight,
    this.radiusBottomLeft,
    this.enableRouting = true,
    this.beforeOnTap,
    this.showEmotions = true,
    this.alwaysShowSkeleton = false,
    this.finishLabelVisible = false,
    this.expirationTimerSettings = const ExpirationTimerSettings(),
    Key? key,
  }) : super(key: key);

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  bool _isLoaded = false;
  int _attempt = 0;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    var expiredInDays =
        widget.book.expirationTimerDays(context.read<SharedPreferences>());
    if (widget.expirationTimerSettings.alwaysHidden) {
      expiredInDays = null;
    }

    BorderRadius borderRadius = BorderRadius.only(
      topRight: Radius.circular(widget.radiusTopRight ?? widget.radius),
      bottomRight: Radius.circular(widget.radiusBottomRight ?? widget.radius),
      topLeft: Radius.circular(widget.radiusTopLeft ?? widget.radius),
      bottomLeft: Radius.circular(widget.radiusBottomLeft ?? widget.radius),
    );

    final isFinished = context
        .select<LibraryState, bool>((state) => state.isFinished(widget.book));

    final url = widget.book.coverUrl;

    return Column(
      children: [
        if (expiredInDays == null &&
            widget.expirationTimerSettings.alignWithOtherInRow)
          SizedBox(height: widget.expirationTimerSettings.height),
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: borderRadius,
          child: Column(
            children: [
              if (expiredInDays != null)
                Container(
                  height: widget.expirationTimerSettings.height,
                  color: expiredInDays == 0
                      ? ThemeColors.accentBlueTextTabActive
                      : ThemeColors.pink,
                  child: Center(
                    child: widget.book.expirationTimerLeavingIn(
                        expiredInDays, widget.expirationTimerSettings.style),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  widget.beforeOnTap?.call();
                  if (widget.enableRouting) {
                    Log.dialog(
                        context, "Navigate to the book ${widget.book.id}");
                  }
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(builder: (context, constraints) {
                    final realSize = (constraints.maxHeight *
                            MediaQuery.of(context).devicePixelRatio)
                        .toInt();

                    final cachedImage = CachedNetworkImage(
                      imageUrl: url,
                      // progressIndicatorBuilder: _cachedProgressIndicatorBuilder,
                      // imageBuilder: (context, provider) =>
                      //     Container(color: Colors.yellow.withOpacity(0.2)),
                      errorWidget: _cachedErrorWidget,
                      width: maxWidth,
                      height: maxWidth,
                      memCacheWidth: realSize,
                      memCacheHeight: realSize,
                      cacheManager: CustomCacheManager.instance,
                      key: ValueKey(url),
                      cacheKey: url + _attempt.toString(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => widget.alwaysShowSkeleton
                          ? const SizedBox.shrink()
                          : const CoverSkeleton(),
                    );
                    const double blurGoneSigma = 5;

                    return Stack(
                      children: [
                        if (widget.alwaysShowSkeleton) const CoverSkeleton(),
                        (expiredInDays == 0 &&
                                widget.expirationTimerSettings.blurWhenGone)
                            ? ClipRect(
                                child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      tileMode: TileMode.decal,
                                      sigmaX: blurGoneSigma,
                                      sigmaY: blurGoneSigma,
                                    ),
                                    child: cachedImage),
                              )
                            : cachedImage,
                        if (isFinished && widget.finishLabelVisible)
                          const _ChipsFinished(),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //TODO: there is no option to reload image by clicking or smth.
  Widget _cachedErrorWidget(
    BuildContext context,
    String url,
    dynamic error,
  ) {
    _setLoadedIfNeeded();

    final textStyle = ThemeTextStyle.s16w700.copyWith(color: Colors.white);

    return GestureDetector(
      onTap: () {
        setState(() {
          _attempt++;
        });
      },
      child: Container(
        color: const Color(0xFF6B768B),
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 3,
              child: FittedBox(
                child: Column(
                  children: [
                    Text("", style: textStyle),
                    const SizedBox(height: 16),
                    Image.asset(
                      "assets/images/icons/image_info.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 16),
                    Text("Loading error try again", style: textStyle),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
        // child:
      ),
    );
  }

  void _setLoadedIfNeeded() {
    if (mounted && !_isLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _isLoaded = true;
        });
      });
    }
  }
}

class CoverSkeleton extends StatelessWidget {
  const CoverSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: const ThemeSceleton(
        child: ColoredBox(color: Colors.white),
      ),
    );
  }
}

class _ChipsFinished extends StatelessWidget {
  const _ChipsFinished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: const Color(0x00000000).withOpacity(0.5),
          // color: Colors.green,
        )),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                    width: 0.5, color: Colors.white.withOpacity(0.2)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Stack(children: [
                IOSBackgroundBlur(
                  baseColor: ThemeColors.accentBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.5),
                        child: Image.asset(
                          'assets/images/icons/checkboxes.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Finished',
                        style: ThemeTextStyle.s13w600.copyWith(
                            color: const Color(0xFFFFFFFF).withOpacity(0.8)),
                      ),
                      const SizedBox(width: 7),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
