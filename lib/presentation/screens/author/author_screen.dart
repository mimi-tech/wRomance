import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/common/widgets/background.dart';
import 'package:womanly_mobile/presentation/common/widgets/book_shelf.dart';
import 'package:womanly_mobile/presentation/common/widgets/close_dialog_button.dart';
import 'package:womanly_mobile/presentation/common/widgets/top_shadow.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_athor_like.dart';
import 'package:womanly_mobile/presentation/misc/expiration_timer/expiration_timer_settings.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/screens/author/widgets/social_network_widget.dart';
import 'package:womanly_mobile/presentation/screens/product/widgets/author_avatar.dart';
import 'package:womanly_mobile/presentation/screens/product/widgets/description_text_widget.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

import '../../misc/analytics/placement.dart';

class AuthorScreen extends StatelessWidget {
  final Actor actor;
  final String placement;
  final String? placementForBooks;
  const AuthorScreen({
    required this.actor,
    required this.placement,
    this.placementForBooks,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booksOriginal = List.of(actor.books(BookShelf.availableBooks(
        context, context.read<DataRepository>().books)));
    final books = _specialSort(context.read<DataRepository>(), booksOriginal);
    final isLiked = context.select<LibraryState, bool>(
        (state) => state.favoriteAuthors.contains(actor));

    return Placement.named(
      placement,
      builder: (context) => Material(
        child: Stack(
          children: [
            Background(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 47),
                child: SafeArea(
                  child: Column(
                    children: [
                      AuthorAvatar(actor, size: 118),
                      const SizedBox(height: 20),
                      Text(
                        "Author",
                        style: ThemeTextStyle.s14w400.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Analytics.logEvent(
                              EventAuthorLike(context, actor, !isLiked));
                          if (isLiked) {
                            context
                                .read<LibraryState>()
                                .removeFavoriteAuthor(actor);
                          } else {
                            context
                                .read<LibraryState>()
                                .addFavoriteAuthor(actor);
                          }
                        },
                        icon: Image.asset(
                          isLiked
                              ? 'assets/images/icons/author_liked.png'
                              : 'assets/images/icons/author_like.png',
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          actor.name,
                          style: ThemeTextStyle.s17w600.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _authorSubGenres(books),
                        style: ThemeTextStyle.s14w400.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SocialNetwork(actor),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AuthorAbout(actor),
                      ),
                      const SizedBox(height: 16),
                      Placement.named(
                        placementForBooks ??
                            "author_page;author_id=${actor.id}",
                        child: BookShelf(
                          books.toList(),
                          columns: 2,
                          beforeOnTap: (book) {
                            Navigator.of(context).pop();
                          },
                          expirationTimerSettings:
                              const ExpirationTimerSettings(
                            style: ExpirationTimerBannerStyle.normal,
                          ),
                          distorted2ColumnList: true,
                          finishLabelVisible: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const TopShadow(),
            SafeArea(
              child: CloseDialogButton(
                  color: const Color(0xFFF9F9F9).withOpacity(0.1)),
            ),
          ],
        ),
      ),
    );
  }

  List<Book> _specialSort(DataRepository dataRepository, List<Book> books) {
    List<Book> result = [];
    List<Book> outOfSeries = [];
    Map<Series, List<Book>> series = {};
    for (int i = 0; i < books.length; i++) {
      final Book it = books[i];
      final seria = dataRepository.getSeries(it);
      if (seria != null) {
        final list = series[seria] ?? [];
        list.add(it);
        series[seria] = list;
      } else {
        outOfSeries.add(it);
      }
    }

    series.forEach((seria, list) {
      list.sort(
          ((a, b) => seria.books.indexOf(a).compareTo(seria.books.indexOf(b))));
      result.addAll(list);
    });

    outOfSeries.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    result.addAll(outOfSeries);

    return result;
  }

  String _authorSubGenres(List<Book> books) {
    final Set<String> subGenres = {};
    for (var element in books) {
      subGenres.addAll(element.subGenres);
    }

    final result = subGenres.take(3).toList();
    return result.join(" • ");
  }
}

class AuthorAbout extends StatefulWidget {
  final Actor actor;
  const AuthorAbout(this.actor, {Key? key}) : super(key: key);

  @override
  State<AuthorAbout> createState() => _AuthorAboutState();
}

class _AuthorAboutState extends State<AuthorAbout> {
  String _about = "";

  @override
  void initState() {
    super.initState();
    context.read<DataRepository>().getAuthorAbout(widget.actor).then((value) {
      if (mounted) {
        setState(() {
          _about = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DescriptionTextWidget(_about, viewAuthor: true);
  }
}
