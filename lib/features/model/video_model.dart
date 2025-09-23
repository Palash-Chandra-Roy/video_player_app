class VideoModel {
  final String id;
  final String title;
  final String duration;
  final String thumbnail;
  final String? description;
  final String? subtitle;
  final bool? isDownloaded;
  final int? downloadProgress;

  VideoModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnail,
    this.description,
    this.subtitle,
    this.isDownloaded,
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
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }
}
