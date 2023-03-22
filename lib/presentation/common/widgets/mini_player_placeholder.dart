import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';

class MiniPlayerPlaceholder extends StatelessWidget {
  const MiniPlayerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentBook =
        context.select<LibraryState, Book?>((state) => state.currentBook);
    return Container(
      // color: Colors.amber,
      // color: ThemeColors.accentBackground,
      height: 60 + (currentBook == null ? 0 : 50),
    );
  }
}
