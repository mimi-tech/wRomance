import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_style.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured/featured_small.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured/featured_medium.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/misc/mixins/resettable.dart';

class FeaturedBooks extends StatefulWidget {
  final Featured featured;
  final bool showPeppers;
  final bool showCovers;
  const FeaturedBooks(
    this.featured, {
    this.showPeppers = false,
    this.showCovers = true,
    Key? key,
  }) : super(key: key);

  @override
  State<FeaturedBooks> createState() => _FeaturedBooksState();
}

class _FeaturedBooksState extends State<FeaturedBooks> with Resettable {
  ScrollController? scrollController;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featured.books.isEmpty) {
      return const SizedBox.shrink();
    }

    FeaturedStyle style = widget.featured.style;
    if (widget.featured.isFreeMarker) {
      style = FeaturedStyle.medium;
    }

    switch (style) {
      case FeaturedStyle.medium:
      case FeaturedStyle.mediumAndRedButton:
        scrollController ??= ScrollController();
        return FeaturedMedium(
          widget.featured,
          controller: scrollController!,
          showPeppers: widget.showPeppers,
        );
      case FeaturedStyle.small:
        scrollController ??= ScrollController();
        return FeaturedSmall(
          widget.featured,
          controller: scrollController!,
          showPeppers: widget.showPeppers,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void reset() {
    scrollController?.jumpTo(0);
    final controller = pageController;
    if (controller != null && controller.positions.isNotEmpty) {
      controller.jumpToPage(controller.initialPage);
    }
  }
}
