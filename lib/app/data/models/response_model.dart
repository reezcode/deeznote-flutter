class ResponseModel {
  final bool success;
  final String? message;
  final dynamic data;

  ResponseModel({required this.success, this.message, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': success,
        'message': message,
        'data': data,
      };
}
