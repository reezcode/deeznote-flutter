// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final dynamic data;

  ResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'status': success, 'message': message, 'data': data, 'success': success};
}
