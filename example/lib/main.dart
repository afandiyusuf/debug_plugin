import 'package:flutter/material.dart';
import 'package:debug_plugin/debug_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DebugPlugin().initialize(); // Initialize the plugin first
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _debugPlugin = DebugPlugin();
  int _logCount = 0;

  @override
  void initState() {
    super.initState();
    // Add a test log on startup
    _debugPlugin.logDebug('AppStartup', 'Application initialized successfully');
  }

  void _addDebugLog() async {
    setState(() {
      _logCount++;
    });
    await _debugPlugin.logDebug('ButtonPress', 'Button pressed $_logCount time(s)');
  }

  void _showDebugConsole() async {
    await _debugPlugin.showDebugScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Debug Plugin Example'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: _showDebugConsole,
              tooltip: 'Show Debug Console',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Debug Plugin Demo', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text('Log entries created: $_logCount'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _addDebugLog,
                child: const Text('Add Debug Log'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showDebugConsole,
                child: const Text('Show Debug Console'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
