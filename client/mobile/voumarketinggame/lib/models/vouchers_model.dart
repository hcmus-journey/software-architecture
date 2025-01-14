class VoucherModel {
  final String voucherId;
  final String playerId;
  final String eventId;
  final String code;
  final String status;
  final DateTime receivedAt; // Đổi từ String thành DateTime
  final DateTime expiredAt; // Đổi từ String thành DateTime
  final double discount;

  VoucherModel({
    required this.voucherId,
    required this.playerId,
    required this.eventId,
    required this.code,
    required this.status,
    required this.receivedAt,
    required this.expiredAt,
    required this.discount,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      voucherId: json['voucherId'],
      playerId: json['playerId'],
      eventId: json['eventId'],
      code: json['code'],
      status: json['status'],
      receivedAt: DateTime.parse(json['receivedAt']), // Parse String thành DateTime
      expiredAt: DateTime.parse(json['expiredAt']), // Parse String thành DateTime
      discount: json['discount'] is int
          ? (json['discount'] as int).toDouble()
          : json['discount'],
    );
  }
}
