// import 'package:flutter_test/flutter_test.dart';
// import 'package:debug_plugin/debug_plugin.dart';
// import 'package:debug_plugin/debug_plugin_platform_interface.dart';
// import 'package:debug_plugin/debug_plugin_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockDebugPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements DebugPluginPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final DebugPluginPlatform initialPlatform = DebugPluginPlatform.instance;

//   test('$MethodChannelDebugPlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelDebugPlugin>());
//   });

//   test('getPlatformVersion', () async {
//     DebugPlugin debugPlugin = DebugPlugin();
//     MockDebugPluginPlatform fakePlatform = MockDebugPluginPlatform();
//     DebugPluginPlatform.instance = fakePlatform;

//     expect(await debugPlugin.getPlatformVersion(), '42');
//   });
// }
