import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'debug_plugin_platform_interface.dart';

/// An implementation of [DebugPluginPlatform] that uses method channels.
class MethodChannelDebugPlugin extends DebugPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('debug_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
