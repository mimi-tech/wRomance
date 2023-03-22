import 'dart:math';
import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_style.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/screens/product/product_screen.dart';

class ProductState extends ChangeNotifier {
  double get buttonPosition => _buttonPosition;
  double get offset => _offset;
  bool get isAppBarOpaque =>
      _hasClients && _offset > ProductScreenBody.appBarOpacityLimitOffset;
  Featured? get moreLikeThis => _moreLikeThis;
  Featured? _moreLikeThis;

  double _buttonPosition = -1;
  double _offset = 0;
  bool _hasClients = true;

  void setButtonPosition(
      double offset, double limit, double minPosition, bool hasClients) {
    _offset = offset;
    _hasClients = hasClients;
    _buttonPosition = max(minPosition - 1, limit - offset);
    notifyListeners();
  }

  static bool get isFirstEntry => _isFirstEntry;
  static bool _isFirstEntry = true;
  static void setIsFirstEntry(bool flag) {
    _isFirstEntry = flag;
  }

  final Book book;
  final List<String> finishedBookIds;
  final List<Book> allBooks;

  static List<Widget> listSmiley = [];
  static int count = 0;

  ProductState(this.book, this.finishedBookIds, this.allBooks) {
    _getMoreLikeThis();
  }

  void _getMoreLikeThis() async {
    Log.stub();
  }

  bool topChips = true;
  String _text = '';
  String _place = '';
  Color _color = Colors.transparent;

  String get textChips => _text;
  String get placeChips => _place;
  Color get colorChips => _color;

  final Map<String, Color> _colors = {
    'red': const Color(0xFF840707),
    'pink': const Color(0xFFF22FBC),
    'yellow': const Color(0xFFFD9F13),
    'violet': const Color(0xFF7B0EE9),
  };

  void setColorTextChips(Book book) {
    switch (book.id) {
      // Paranormal
      case '206':
        _color = _colors['violet']!;
        _text = 'Paranormal';
        _place = '1';
        topChips = true;
        break;
      case '193':
        _color = _colors['violet']!;
        _text = 'Paranormal';
        _place = '2';
        topChips = true;
        break;
      case '170':
        _color = _colors['violet']!;
        _text = 'Paranormal';
        _place = '3';
        topChips = true;
        break;
      case '112':
        _color = _colors['violet']!;
        _text = 'Paranormal';
        _place = '4';
        topChips = true;
        break;
      // Romcom
      case '165':
        _color = _colors['pink']!;
        _text = 'Romcom';
        _place = '1';
        topChips = true;
        break;
      case '33':
        _color = _colors['pink']!;
        _text = 'Romcom';
        _place = '2';
        topChips = true;
        break;
      case '102':
        _color = _colors['pink']!;
        _text = 'Romcom';
        _place = '3';
        topChips = true;
        break;
      case '35':
        _color = _colors['pink']!;
        _text = 'Romcom';
        _place = '4';
        topChips = true;
        break;
      case '146':
        _color = _colors['pink']!;
        _text = 'Romcom';
        _place = '5';
        topChips = true;
        break;
      // Dark
      case '58':
        _color = _colors['red']!;
        _text = 'Dark';
        _place = '1';
        topChips = true;
        break;
      case '187':
        _color = _colors['red']!;
        _text = 'Dark';
        _place = '2';
        topChips = true;
        break;
      case '209':
        _color = _colors['red']!;
        _text = 'Dark';
        _place = '3';
        topChips = true;
        break;
      case '82':
        _color = _colors['red']!;
        _text = 'Dark';
        _place = '4';
        topChips = true;
        break;
      case '161':
        _color = _colors['red']!;
        _text = 'Dark';
        _place = '5';
        topChips = true;
        break;
      // Contemporary
      case '212':
        _color = _colors['yellow']!;
        _text = 'Contemporary';
        _place = '1';
        topChips = true;
        break;
      case '94':
        _color = _colors['yellow']!;
        _text = 'Contemporary';
        _place = '2';
        topChips = true;
        break;
      case '228':
        _color = _colors['yellow']!;
        _text = 'Contemporary';
        _place = '3';
        topChips = true;
        break;
      case '190':
        _color = _colors['yellow']!;
        _text = 'Contemporary';
        _place = '4';
        topChips = true;
        break;
      case '217':
        _color = _colors['yellow']!;
        _text = 'Contemporary';
        _place = '5';
        topChips = true;
        break;
      default:
        topChips = false;
    }
  }
}
