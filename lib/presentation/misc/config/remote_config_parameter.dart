import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class RemoteConfigParameter<T> {
  final String name;
  final T inAppDefaultValue;
  T? _cachedServerValue;

  RemoteConfigParameter({
    required this.name,
    required this.inAppDefaultValue,
  });

  T getValue(FirebaseRemoteConfig? instance) {
    ///There is a gap from the moment the library of RemoteConfig thinks
    ///that values are activated and actual time when we can use them.
    ///This is not fixed by delay. At that gap we always get static default values
    ///and can misuse them as real ones.
    dynamic staticDefaultValueOf() {
      switch (T) {
        case int:
          return RemoteConfigValue.defaultValueForInt;
        case double:
          return RemoteConfigValue.defaultValueForDouble;
        case String:
          return RemoteConfigValue.defaultValueForString;
        //don't include until it is really needed
        // case bool: return RemoteConfigValue.defaultValueForString;
      }
      return null;
    }

    T getter({
      required Function? serverGetter,
      required Function prefsGetter,
      required Function prefsSetter,
    }) {
      try {
        final serverValue = _cachedServerValue ?? serverGetter?.call(name);
        final realServerValue = instance?.getAll().containsKey(name) ?? false;
        //if there is no value on server for key $name -> staticDefaultValueOf will be used (''/0/0.0/false), no null
        if (serverValue != null && realServerValue) {
          if (_cachedServerValue == null) {
            _cachedServerValue = serverValue;
            prefsSetter(_defaultValueKey, serverValue);
          }
          return serverValue as T;
        }
      } catch (e) {
        Log.print(e);
      }
      return prefsGetter(_defaultValueKey) ?? inAppDefaultValue;
    }

    switch (T) {
      case int:
        {
          return getter(
            serverGetter: instance?.getInt,
            prefsGetter: sharedPreferences.getInt,
            prefsSetter: sharedPreferences.setInt,
          );
        }
      case bool:
        {
          return getter(
            serverGetter: instance?.getBool,
            prefsGetter: sharedPreferences.getBool,
            prefsSetter: sharedPreferences.setBool,
          );
        }
      case String:
        {
          return getter(
            serverGetter: instance?.getString,
            prefsGetter: sharedPreferences.getString,
            prefsSetter: sharedPreferences.setString,
          );
        }
    }
    return inAppDefaultValue;
  }

  String get _defaultValueKey => "RemoteConfigField.defaultValueKey.$name";
}
