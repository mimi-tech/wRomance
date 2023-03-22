import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/presentation/misc/cache/custom_cache_manager.dart';
import 'package:womanly_mobile/presentation/misc/config/new_design.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class AuthorAvatar extends StatelessWidget {
  final Actor actor;
  final double size;
  late final placeholder = ActorPlaceholder(_firstLetters());
  AuthorAvatar(this.actor, {this.size = 60, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final realSize = (size * MediaQuery.of(context).devicePixelRatio).toInt();
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: SizedBox(
        width: size,
        height: size,
        child: actor.avatarUrl.isEmpty
            ? placeholder
            : CachedNetworkImage(
                imageUrl: actor.avatarUrl,
                placeholder: (context, _) => placeholder,
                errorWidget: (context, _, __) => placeholder,
                memCacheWidth: realSize,
                memCacheHeight: realSize,
                cacheManager: CustomCacheManager.instance,
              ),
      ),
    );
  }

  String _firstLetters() {
    return actor.name
        .split(' ')
        .where((it) => it.isNotEmpty)
        .map((it) => it[0])
        .take(2)
        .join()
        .toUpperCase();
  }
}

class ActorPlaceholder extends StatelessWidget {
  final String letters;
  const ActorPlaceholder(this.letters, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.accentBlueButtons,
      child: Center(
        child: Text(
          letters,
          style: newProduct
              ? ThemeTextStyle.s22w700.copyWith(
                  color: Colors.white,
                )
              : ThemeTextStyle.s28w700.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
