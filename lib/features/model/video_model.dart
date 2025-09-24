class VideoModel {
  final String id;
  final String title;
  final String duration;
  final String thumbnail;
  final String? description;
  final String? subtitle;
  final bool? isDownloaded;
  final String url; // নতুন যোগ
  final int? downloadProgress;

  VideoModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnail,
    this.description,
    this.subtitle,
    this.isDownloaded,
    required this.url,
    this.downloadProgress,
  });

  VideoModel copyWith({
    String? id,
    String? title,
    String? duration,
    String? thumbnail,
    String? description,
    String? subtitle,
    bool? isDownloaded,
    String? url,
    int? downloadProgress,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      subtitle: subtitle ?? this.subtitle,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      url: url ?? this.url, // copyWith এ যোগ
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }
}
