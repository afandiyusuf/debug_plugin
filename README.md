# Debug Plugin

A Flutter plugin for in-app debugging that provides a simple way to log and view debug information during development and testing.

## Features

- **Debug Logging**: Log debug information with feature names and timestamps
- **Debug Screen**: Display a built-in debug console within your app
- **Search Capability**: Search through logs by feature or content
- **Persistent Storage**: Logs persist between app restarts using SharedPreferences
- **Simple Integration**: Easy to add to any Flutter application

## Installation

Add the debug_plugin to your `pubspec.yaml`:

```yaml
dependencies:
  debug_plugin: ^0.0.1
```

Run:
```
flutter pub get
```

## Usage

### Initialize the plugin

Before using the plugin, you need to initialize it:

```dart
import 'package:debug_plugin/debug_plugin.dart';

// In your app initialization
await DebugPlugin().initialize();
```

### Logging debug information

```dart
// Log debug information with a feature name and message
DebugPlugin().logDebug('YourFeatureName', 'This is a debug message');
```

### Display the debug console

```dart
// Show the debug screen when needed (e.g., in a developer menu)
DebugPlugin().showDebugScreen(context);
```

The debug screen provides:
- A search field to filter logs
- A scrollable list of all logs with timestamps
- A button to clear all logs

## Example

```dart
import 'package:flutter/material.dart';
import 'package:debug_plugin/debug_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DebugPlugin().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Debug Plugin Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  DebugPlugin().logDebug('ButtonPress', 'Button was pressed');
                },
                child: const Text('Log Debug Event'),
              ),
              ElevatedButton(
                onPressed: () {
                  DebugPlugin().showDebugScreen(context);
                },
                child: const Text('Show Debug Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Requirements

- Flutter SDK: >=3.0.0 <4.0.0
- Dart SDK: >=3.0.0 <4.0.0

## Dependencies

- shared_preferences: ^2.2.0

## License

This project is licensed under the [LICENSE](LICENSE) file in the root directory of this project.
