import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/config/new_design.dart';

class BookPeppers extends StatelessWidget {
  static const double height = 24;

  final Book book;
  const BookPeppers({
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (book.hotPeppers <= 0) {
    //   return const SizedBox.shrink();
    // }

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Pepper(isTransparent: book.hotPeppers < 1),
          _Pepper(isTransparent: book.hotPeppers < 2),
          _Pepper(isTransparent: book.hotPeppers < 3),
        ],
      ),
    );
  }
}

class _Pepper extends StatelessWidget {
  final bool isTransparent;
  const _Pepper({
    required this.isTransparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Opacity(
        opacity: isTransparent && newProduct
            ? 0.25
            : isTransparent && !newProduct
                ? 0.5
                : 1.0,
        // opacity: isTransparent ? 0.25 : 1.0,
        child: Image.asset(
          "assets/images/icons/emoji/hot_pepper.png",
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
