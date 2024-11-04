// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/widgets.dart';

import 'debug_plugin_platform_interface.dart';

class DebugPlugin {
  Future<String?> getPlatformVersion() {
    return DebugPluginPlatform.instance.getPlatformVersion();
  }

  showDebugScreen(BuildContext context) {
    return DebugPluginPlatform.instance.showDebugScreen(context);
  }

  logDebug(String feature, String log) async {
    feature = DateTime.now().toIso8601String().toString() + " | " + feature;
    return DebugPluginPlatform.instance.logDebug(feature, log);
  }

  initialize() async {
    return DebugPluginPlatform.instance.initialize();
  }
}
