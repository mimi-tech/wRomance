import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_tap_on_author.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/misc/routing/popup.dart';
import 'package:womanly_mobile/presentation/screens/author/author_screen.dart';
import 'package:womanly_mobile/presentation/screens/product/widgets/author_avatar.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class AuthorListItem extends StatelessWidget {
  final Actor author;
  final String? placementForBooks;
  const AuthorListItem(this.author, {this.placementForBooks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.width - 60) / 3;
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          Analytics.logEvent(EventTapOnAuthor(context, author));
          Popup.show(
            AuthorScreen(
              actor: author,
              placement: context.read<Placement>().name,
              placementForBooks: placementForBooks,
            ),
            context: context,
          );
        },
        child: Column(
          children: [
            AuthorAvatar(author, size: size),
            const SizedBox(height: 10),
            Text(
              author.nameSplitted,
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: ThemeTextStyle.s14w400.copyWith(
                color: const Color(0xB3FFFFFF),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
