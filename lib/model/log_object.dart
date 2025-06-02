class LogObject {
  String? feature;
  String? log;
  
  LogObject({this.feature, this.log});
  
  // Convert to JSON for SharedPreferences storage
  Map<String, dynamic> toJson() {
    return {
      'feature': feature,
      'log': log,
    };
  }
  
  // Create LogObject from JSON
  factory LogObject.fromJson(Map<String, dynamic> json) {
    return LogObject(
      feature: json['feature'],
      log: json['log'],
    );
  }
}
