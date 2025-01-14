class EventModel {
  final String eventId;
  final String brandId;
  final String brandName;
  final String brandImageUrl;
  final String name;
  final String imageUrl;
  final String startTime;
  final String endTime;
  final String description;
  final int totalVouchers;
  final int redeemedVouchers;
  final String status;
  final String createdAt;
  final double discountPercentage;
  final List<GameModel> games;

  EventModel({
    required this.eventId,
    required this.brandId,
    required this.brandName,
    required this.brandImageUrl,
    required this.name,
    required this.imageUrl,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.totalVouchers,
    required this.redeemedVouchers,
    required this.status,
    required this.createdAt,
    required this.discountPercentage,
    required this.games,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['eventId'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      brandImageUrl: json['brandImageUrl'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      description: json['description'],
      totalVouchers: json['totalVouchers'],
      redeemedVouchers: json['redeemedVouchers'] ?? 0,
      status: json['status'],
      createdAt: json['createdAt'],
      discountPercentage: json['discountPercentage'].toDouble(),
      games: (json['games'] as List)
          .map((game) => GameModel.fromJson(game))
          .toList(),
    );
  }
}

class GameModel {
  final String gameId;
  final String description;
  final String imageUrl;
  final String name;
  final String type;

  GameModel({
    required this.gameId,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.type,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      gameId: json['gameId'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      type: json['type'],
    );
  }
}
