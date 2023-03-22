import 'package:womanly_mobile/presentation/misc/log.dart';

class SpecialOffer {
  /// Price template like {{book_offer_1}} used
  final String title;

  /// Substring to highlight it in UI, can be empty
  final String priceSubstring;

  final List<SpecialOfferDetails> details;

  SpecialOffer(this.title, this.priceSubstring, this.details);

  static SpecialOffer? fromJson(
      Map<String, dynamic>? json, String Function(String) getPriceByProductId) {
    if (json == null) {
      return null;
    }

    try {
      final details = (json['details'] as List<dynamic>)
          .map((it) => SpecialOfferDetails.fromJson(it))
          .where((it) => it != null)
          .cast<SpecialOfferDetails>()
          .toList();
      String title = json['title'] as String;
      final offerProductMatch = RegExp(r'{{.*}}').stringMatch(title);
      String priceSubstring = "";
      if (offerProductMatch != null) {
        final offerProductId =
            offerProductMatch.replaceAll("{", "").replaceAll("}", "");
        priceSubstring = getPriceByProductId(offerProductId);
        title = title.replaceAll(offerProductMatch, priceSubstring);
      }

      return SpecialOffer(
        title,
        priceSubstring,
        details,
      );
    } catch (e) {
      Log.errorParsingSpecialOfferFromJson(e);
      return null;
    }
  }
}

class SpecialOfferDetails {
  final List<int> ids;
  final String price;

  SpecialOfferDetails(this.ids, this.price);

  static SpecialOfferDetails? fromJson(Map<String, dynamic> json) {
    try {
      final ids = (json['ids'] as List<dynamic>).cast<int>();
      final String price = json['price'];
      return SpecialOfferDetails(ids, price);
    } catch (e) {
      Log.errorParsingSpecialOfferDetailsFromJson(e);
      return null;
    }
  }
}
