import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/presentation/common/widgets/book_cover.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured/featured_list.dart';

class FeaturedSmall extends FeaturedList {
  const FeaturedSmall(
    Featured featured, {
    required bool showPeppers,
    required ScrollController controller,
    Key? key,
  }) : super(
          featured,
          164,
          controller: controller,
          showPeppers: showPeppers,
          key: key,
        );
}
