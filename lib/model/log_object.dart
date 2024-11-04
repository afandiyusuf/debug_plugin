import 'package:hive/hive.dart';

part 'log_object.g.dart';

@HiveType(typeId: 0)
class LogObject extends HiveObject {
  @HiveField(0)
  String? feature;
  @HiveField(1)
  String? log;
}
