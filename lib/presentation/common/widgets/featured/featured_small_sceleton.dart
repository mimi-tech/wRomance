import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/presentation/common/widgets/book_cover.dart';
import 'package:womanly_mobile/presentation/common/widgets/featured/featured_list.dart';

class FeaturedSmallSceleton extends FeaturedList {
  const FeaturedSmallSceleton({Key? key})
      : super(
          null,
          164,
          showPeppers: false,
          key: key,
        );
}
