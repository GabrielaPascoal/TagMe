class ResponseRequest {
  String returnMsg;
  int statusCode;

  ResponseRequest({
    required this.returnMsg,
    required this.statusCode,
  });

  factory ResponseRequest.fromMap(Map<String, dynamic> json) {
    return ResponseRequest(
      returnMsg: json['returnMsg'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
