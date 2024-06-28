class MediaModel {
  final int? id;
  final int? order;
  final String? mediaUrl;
  final String? hash;

  MediaModel({
    this.id,
    this.order,
    this.mediaUrl,
    this.hash,
  });

  factory MediaModel.fromJson(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id']?.toInt(),
      order: map['order']?.toInt(),
      mediaUrl: map['media_url'],
      hash: map['hash'],
    );
  }
}
