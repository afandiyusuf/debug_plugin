import 'package:debug_plugin/model/log_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'debug_plugin_method_channel.dart';

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    Hive.registerAdapter(LogObjectAdapter());
    await Hive.openBox<LogObject>('logBox');
  }

  showDebugScreen(BuildContext context) {
    var box = Hive.box<LogObject>("logBox");
    List<LogObject> logs = box.values.toList();
    //invert the list
    logs = logs.reversed.toList();

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
                          Text("Debug Search"),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                logs = box.values
                                    .where((element) =>
                                        element.feature!
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        element.log!
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                    .toList();
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              removeAllDebug();
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
                                      "|" +
                                          logs[i].feature! +
                                          "|" +
                                          logs[i].log!,
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

  logDebug(String feature, String log) {
    var box = Hive.box<LogObject>("logBox");
    var logDebug = new LogObject();
    logDebug.feature = feature;
    logDebug.log = log;
    box.add(logDebug);
  }

  removeAllDebug() {
    var box = Hive.box<LogObject>("logBox");
    box.clear();
  }
}
