class ReelModel {
  final int id;
  final String? title;
  final String? cdnUrl;
  final String? thumbCdnUrl;
  final String? userFullname;
  final String? categoryTitle;
  final int duration;
  final String? orientation;
  final int? videoHeight;
  final int? videoWidth;
  final String? profilePicture;
  final int totalViews;
  final int totalLikes;
  final int totalComments;
  final int totalShare;
  final String? description;

  ReelModel({
    required this.id,
    required this.title,
    required this.cdnUrl,
    required this.thumbCdnUrl,
    required this.userFullname,
    required this.categoryTitle,
    required this.duration,
    required this.orientation,
    required this.videoHeight,
    required this.videoWidth,
    required this.profilePicture,
    required this.totalViews,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShare,
    required this.description,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'] ?? 0,
      title: json['title'] as String?,
      cdnUrl: json['cdn_url'] as String?,
      thumbCdnUrl: json['thumb_cdn_url'] as String?,
      userFullname: json['user']?['fullname'] as String?,
      categoryTitle: json['category']?['title'] as String?,
      duration: json['duration'] ?? 0,
      orientation: json['orientation'] as String?,
      videoHeight: json['video_height'] as int?,
      videoWidth: json['video_width'] as int?,
      profilePicture: json['user']?['profile_picture'] as String?,
      totalViews: json['total_views'] ?? 0,
      totalLikes: json['total_likes'] ?? 0,
      totalComments: json['total_comments'] ?? 0,
      totalShare: json['total_share'] ?? 0,
      description: json['description'] as String?,
    );
  }
}