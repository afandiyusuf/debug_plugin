import 'dart:convert';

import 'package:debug_plugin/model/log_object.dart';
import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Implementation is now included in this file

abstract class DebugPluginPlatform extends PlatformInterface {
  /// Constructs a DebugPluginPlatform.
  DebugPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static DebugPluginPlatform _instance = MethodChannelDebugPlugin();

  /// The default instance of [DebugPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelDebugPlugin].
  static DebugPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DebugPluginPlatform] when
  /// they register themselves.
  static set instance(DebugPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize() async {
    // Ensure shared preferences is ready
    await SharedPreferences.getInstance();
  }

  Future<void> showDebugScreen(BuildContext context);

  Future<void> logDebug(String feature, String log);

  Future<void> removeAllDebug();

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

class MethodChannelDebugPlugin extends DebugPluginPlatform {
  @override
  Future<void> showDebugScreen(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> logsJson = prefs.getStringList('logs') ?? [];

    // Parse JSON strings to LogObject instances
    List<LogObject> logs = logsJson.map((jsonStr) {
      Map<String, dynamic> json = jsonDecode(jsonStr);
      return LogObject.fromJson(json);
    }).toList();

    // Reverse to show newest first
    logs = logs.reversed.toList();

    // Store original logs for filtering
    List<LogObject> allLogs = List.from(logs);

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Material(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Debug Search"),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  logs = List.from(allLogs);
                                } else {
                                  logs = allLogs
                                      .where((element) =>
                                          element.feature!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.log!
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                      .toList();
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await removeAllDebug();
                              logs = [];
                              allLogs = [];
                              setState(() {});
                            },
                            child: Text("Clear All"),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: logs.length,
                          itemBuilder: (c, i) {
                            return Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "|  ${logs[i].feature!} | ${logs[i].log!}",
                                      softWrap: true,
                                    )),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            );
          });
        });
  }

  Future<void> logDebug(String feature, String log) async {
    final prefs = await SharedPreferences.getInstance();
    final logDebug = LogObject(feature: feature, log: log);

    // Get existing logs
    List<String> logsJson = prefs.getStringList('logs') ?? [];

    // Add new log as JSON string
    logsJson.add(jsonEncode(logDebug.toJson()));

    // Save back to SharedPreferences
    await prefs.setStringList('logs', logsJson);
  }

  Future<void> removeAllDebug() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logs');
  }
}
