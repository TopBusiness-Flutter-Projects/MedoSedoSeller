class NotificationModel {
  int? id;
  String? type;
  String? title;
  String? description;
  String? notificationCount;
  String? image;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.type,
    this.title,
    this.description,
    this.notificationCount,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        description: json["description"],
        notificationCount: json["notification_count"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "description": description,
        "notification_count": notificationCount,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
