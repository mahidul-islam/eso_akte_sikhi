// ignore_for_file: non_constant_identifier_names

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class RemoteConfigService extends GetxService {
  RemoteConfigService() {
    _initialise();
  }

  static RemoteConfigService get to => Get.find();

  static String STROOP_TEST = 'STROOP_TEST';
  static String REACTION_TEST_COUNT = 'REACTION_TEST_COUNT';

  FirebaseRemoteConfig get _remoteConfig => FirebaseRemoteConfig.instance;

  final Map<String, dynamic> defaults = <String, dynamic>{
//
  };

  Future<FirebaseRemoteConfig> _initialise() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          minimumFetchInterval: const Duration(minutes: 1),
          fetchTimeout: const Duration(minutes: 1),
        ),
      );
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (_) {}
    return Future<FirebaseRemoteConfig>.value(_remoteConfig);
  }

  Future<void> _fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  int get reactionTestCount => _remoteConfig.getInt(REACTION_TEST_COUNT);
  bool get stroopTest => _remoteConfig.getBool(STROOP_TEST);
}
