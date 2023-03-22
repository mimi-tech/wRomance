import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPurchaseAF extends AnalyticsEvent {
  final Book book;
  final double price;
  EventPurchaseAF(this.book, this.price);

  @override
  String get eventName => 'af_purchase';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => {
        "af_content_id": book.id,
        "af_revenue": price,
        "af_currency": "USD",
      };
}
