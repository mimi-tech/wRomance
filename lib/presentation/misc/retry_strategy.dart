import 'dart:math';

import 'package:womanly_mobile/presentation/misc/log.dart';

enum RetryStrategyDefinitionOfSuccess {
  notNull,
}

/// Allows to retry callback for a period of time
/// Supports up to 5 parameters.
class RetryStrategy {
  final int maxSecondsForRetryAttempts;
  final Function callback;
  final List<dynamic> callbackParameters;
  final RetryStrategyDefinitionOfSuccess definitionOfSuccess;
  final String tag;
  final int delayBetweenAttemptsInSeconds;

  static const _maxSecondsForRetryAttempts = 5 * 60;
  static Set<String> activeTags = {};

  RetryStrategy({
    required this.maxSecondsForRetryAttempts,
    required this.callback,
    required this.callbackParameters,
    required this.definitionOfSuccess,
    required this.tag,
    required this.delayBetweenAttemptsInSeconds,
  });

  Future<dynamic> start() async {
    if (activeTags.contains(tag)) {
      return null;
    }
    activeTags.add(tag);

    final startTs = DateTime.now().millisecondsSinceEpoch;
    final endOfRetriesTs = startTs +
        min(_maxSecondsForRetryAttempts, maxSecondsForRetryAttempts) * 1000;

    dynamic result;
    int attempts = 0;
    bool isSuccess = false;
    do {
      await Future.delayed(Duration(seconds: delayBetweenAttemptsInSeconds));
      attempts++;
      Log.print("==RetryStrategy attempt #$attempts");
      switch (callbackParameters.length) {
        case 0:
          result = await callback.call();
          break;
        case 1:
          result = await callback.call(
            callbackParameters[0],
          );
          break;
        case 2:
          result = await callback.call(
            callbackParameters[0],
            callbackParameters[1],
          );
          break;
        case 3:
          result = await callback.call(
            callbackParameters[0],
            callbackParameters[1],
            callbackParameters[2],
          );
          break;
        case 4:
          result = await callback.call(
            callbackParameters[0],
            callbackParameters[1],
            callbackParameters[2],
            callbackParameters[3],
          );
          break;
        case 5:
          result = await callback.call(
            callbackParameters[0],
            callbackParameters[1],
            callbackParameters[2],
            callbackParameters[3],
            callbackParameters[4],
          );
          break;
      }
      switch (definitionOfSuccess) {
        case RetryStrategyDefinitionOfSuccess.notNull:
          if (result != null) {
            Log.print("==RetryStrategy got result $result");
            isSuccess = true;
          }
          break;
      }
    } while (
        !isSuccess && DateTime.now().millisecondsSinceEpoch < endOfRetriesTs);

    activeTags.remove(tag);

    return result;
  }
}
