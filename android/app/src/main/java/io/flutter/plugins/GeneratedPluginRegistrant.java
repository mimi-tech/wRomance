package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new com.adjust.sdk.flutter.AdjustSdk());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin adjust_sdk, com.adjust.sdk.flutter.AdjustSdk", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.amplitude.amplitude_flutter.AmplitudeFlutterPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin amplitude_flutter, com.amplitude.amplitude_flutter.AmplitudeFlutterPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.appsettings.AppSettingsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin app_settings, com.example.appsettings.AppSettingsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.appsflyer.appsflyersdk.AppsflyerSdkPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin appsflyer_sdk, com.appsflyer.appsflyersdk.AppsflyerSdkPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.ryanheise.audioservice.AudioServicePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin audio_service, com.ryanheise.audioservice.AudioServicePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.ryanheise.audio_session.AudioSessionPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin audio_session, com.ryanheise.audio_session.AudioSessionPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.connectivity.ConnectivityPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin connectivity_plus, dev.fluttercommunity.plus.connectivity.ConnectivityPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin device_info_plus, dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.launchexternalapp.LaunchexternalappPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin external_app_launcher, com.example.launchexternalapp.LaunchexternalappPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new id.oddbit.flutter.facebook_app_events.FacebookAppEventsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin facebook_app_events, id.oddbit.flutter.facebook_app_events.FacebookAppEventsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.analytics.FlutterFirebaseAnalyticsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_analytics, io.flutter.plugins.firebase.analytics.FlutterFirebaseAnalyticsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.crashlytics.FlutterFirebaseCrashlyticsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_crashlytics, io.flutter.plugins.firebase.crashlytics.FlutterFirebaseCrashlyticsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_messaging, io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firebaseremoteconfig.FirebaseRemoteConfigPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_remote_config, io.flutter.plugins.firebase.firebaseremoteconfig.FirebaseRemoteConfigPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.whelksoft.flutter_native_timezone.FlutterNativeTimezonePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_native_timezone, com.whelksoft.flutter_native_timezone.FlutterNativeTimezonePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.britannio.in_app_review.InAppReviewPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin in_app_review, dev.britannio.in_app_review.InAppReviewPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.ryanheise.just_audio.JustAudioPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin just_audio, com.ryanheise.just_audio.JustAudioPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.packageinfo.PackageInfoPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin package_info_plus, dev.fluttercommunity.plus.packageinfo.PackageInfoPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new gabrimatic.info.restart.RestartPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin restart_app, gabrimatic.info.restart.RestartPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.share.SharePlusPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin share_plus, dev.fluttercommunity.plus.share.SharePlusPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.shekarmudaliyar.social_share.SocialSharePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin social_share, com.shekarmudaliyar.social_share.SocialSharePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.tekartik.sqflite.SqflitePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin sqflite, com.tekartik.sqflite.SqflitePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
  }
}
