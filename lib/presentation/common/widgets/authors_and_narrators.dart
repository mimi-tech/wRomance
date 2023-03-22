import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_tap_on_author.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';
import 'package:womanly_mobile/presentation/misc/config/new_design.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/misc/routing/popup.dart';
import 'package:womanly_mobile/presentation/screens/author/author_screen.dart';
import 'package:womanly_mobile/presentation/screens/product/product_screen.dart';
import 'package:womanly_mobile/presentation/screens/product/widgets/author_avatar.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class AuthorsAndNarrators extends StatelessWidget {
  final Book book;
  final bool enableRouting;
  const AuthorsAndNarrators(
    this.book, {
    this.enableRouting = true,
    Key? key,
  }) : super(key: key);
  static const double _itemHeight = 150;

  @override
  Widget build(BuildContext context) {
    final List<Actor> actors = [];
    //add authors first
    actors.addAll(book.actors.where((it) => it.isAuthor));
    actors.addAll(book.actors.where((it) => !it.isAuthor));
    final widgets = actors.map((it) => _ActorItem(it, enableRouting)).toList();

    if (widgets.length < 4) {
      return Container(
        color:
            debugColorListenButtonPositions ? Colors.blue : Colors.transparent,
        padding: EdgeInsets.fromLTRB(
          widgets.length == 2 ? MediaQuery.of(context).size.width / 8 : 0,
          16,
          widgets.length == 2 ? MediaQuery.of(context).size.width / 8 : 0,
          0,
        ),
        child: Row(children: widgets.map((it) => Expanded(child: it)).toList()),
      );
    }
    final count = widgets.length == 4 ? 2 : 3;
    return GridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: count,
      children: widgets,
      childAspectRatio:
          MediaQuery.of(context).size.width / (_itemHeight * count),
      shrinkWrap: true,
    );
  }
}

class _ActorItem extends StatelessWidget {
  final Actor actor;
  final bool enableRouting;
  const _ActorItem(this.actor, this.enableRouting, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enableRouting) {
          return;
        }

        if (actor.isAuthor) {
          Analytics.logEvent(EventTapOnAuthor(context, actor));
          Popup.show(
            AuthorScreen(
              actor: actor,
              placement: context.read<Placement>().name,
            ),
            context: context,
          );
        }
      },
      child: Container(
        height: AuthorsAndNarrators._itemHeight,
        decoration: BoxDecoration(
            // border: Border.all(),
            // color: Colors.amber,
            ),
        child: Column(
          children: [
            AuthorAvatar(actor, size: 60),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                // "a\nb",
                // "a\nb\nc",
                actor.nameSplitted,
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: newProduct
                    ? ThemeTextStyle.s14w500.copyWith(
                        color: const Color(0xB3FFFFFF),
                        height: 1.4,
                        letterSpacing: 0.5)
                    : ThemeTextStyle.s14w400
                        .copyWith(color: const Color(0xB3FFFFFF), height: 1.3),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              actor.isAuthor ? "Author" : "Narrator",
              textAlign: TextAlign.center,
              style: ThemeTextStyle.s14w400.copyWith(
                color: enableRouting && actor.isAuthor
                    ? ThemeColors.accentBlue
                    : Colors.white.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
