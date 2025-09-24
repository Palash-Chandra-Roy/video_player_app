// import 'package:audio_video_player/cores/theme/theme.dart';
// import 'package:audio_video_player/features/model/video_model.dart';
// import 'package:flutter/material.dart';

// class PlaylistScreen extends StatefulWidget {
//   final Function(String) onVideoSelect;
//   final VoidCallback onBack;

//   const PlaylistScreen({
//     super.key,
//     required this.onVideoSelect,
//     required this.onBack,
//   });

//   @override
//   State<PlaylistScreen> createState() => _PlaylistScreenState();
// }

// class _PlaylistScreenState extends State<PlaylistScreen> {
//   List<VideoModel> _playlistVideos = [
//     VideoModel(
//       id: '1',
//       title: 'The Matrix',
//       subtitle: 'Action • Sci-Fi',
//       duration: '2h 16m',
//       url:
//           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       thumbnail: 'https://www.youtube.com/shorts/hhor-qT8-bw',
//       isDownloaded: true,
//       downloadProgress: 100,
//     ),
//     VideoModel(
//       id: '2',
//       title: 'Blade Runner 2049',
//       subtitle: 'Sci-Fi • Thriller',
//       duration: '2h 44m',
//       url:
//           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       thumbnail: 'https://images.unsplash.com/photo-1679699316094-a74534381e22',
//       isDownloaded: false,
//       downloadProgress: 0,
//     ),
//     VideoModel(
//       id: '3',
//       title: 'Ex Machina',
//       subtitle: 'Sci-Fi • Drama',
//       duration: '1h 48m',
//       url:
//           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       thumbnail: 'https://images.unsplash.com/photo-1710988486821-9af47f60d62b',
//       isDownloaded: true,
//       downloadProgress: 100,
//     ),
//     VideoModel(
//       id: '4',
//       title: 'Interstellar',
//       subtitle: 'Sci-Fi • Adventure',
//       duration: '2h 49m',
//       url:
//           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       thumbnail: 'https://images.unsplash.com/photo-1739891251370-05b62a54697b',
//       isDownloaded: false,
//       downloadProgress: 75,
//     ),
//     VideoModel(
//       id: '5',
//       title: 'Inception',
//       subtitle: 'Action • Thriller',
//       duration: '2h 28m',
//       url:
//           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       thumbnail: 'https://images.unsplash.com/photo-1679699316094-a74534381e22',
//       isDownloaded: true,
//       downloadProgress: 100,
//     ),
//   ];

//   void _handleDownload(String videoId) {
//     setState(() {
//       final index = _playlistVideos.indexWhere((video) => video.id == videoId);
//       if (index != -1) {
//         final video = _playlistVideos[index];
//         if (video.downloadProgress == 0) {
//           _playlistVideos[index] = video.copyWith(downloadProgress: 25);
//         }
//       }
//     });
//   }

//   void _handleRemoveFromPlaylist(String videoId) {
//     setState(() {
//       _playlistVideos.removeWhere((video) => video.id == videoId);
//     });
//   }

//   int get _totalVideos => _playlistVideos.length;

//   String get _totalDuration {
//     int totalMinutes = 0;
//     for (final video in _playlistVideos) {
//       final parts = video.duration.split('h ');
//       final hours = int.parse(parts[0]);
//       final minutes = int.parse(parts[1].replaceAll('m', ''));
//       totalMinutes += hours * 60 + minutes;
//     }
//     final hours = totalMinutes ~/ 60;
//     final minutes = totalMinutes % 60;
//     return '${hours}h ${minutes}m';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             _buildHeader(),

//             // Playlist Header
//             _buildPlaylistHeader(),

//             // Video List
//             Expanded(child: _buildVideoList()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: widget.onBack,
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'My Playlist',
//                 style: Theme.of(
//                   context,
//                 ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 '$_totalVideos videos • $_totalDuration',
//                 style: Theme.of(
//                   context,
//                 ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
//               ),
//             ],
//           ),
//           const Spacer(),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.more_vert_rounded,
//               color: AppColors.textPrimary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPlaylistHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: AppColors.appSurface,
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     color: AppColors.neonAccent,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Icon(
//                     Icons.favorite_rounded,
//                     color: Colors.black,
//                     size: 32,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Sci-Fi Collection',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Your favorite sci-fi movies',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       if (_playlistVideos.isNotEmpty) {
//                         widget.onVideoSelect(_playlistVideos.first.id);
//                       }
//                     },
//                     icon: const Icon(Icons.play_arrow_rounded),
//                     label: const Text('Play All'),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.download_for_offline_rounded),
//                     label: const Text('Download All'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVideoList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _playlistVideos.length,
//       itemBuilder: (context, index) {
//         final video = _playlistVideos[index];
//         return _buildVideoItem(video);
//       },
//     );
//   }

//   Widget _buildVideoItem(VideoModel video) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.appSurface,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 // Thumbnail
//                 GestureDetector(
//                   onTap: () => widget.onVideoSelect(video.id),
//                   child: Container(
//                     width: 64,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: AppColors.appCard,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: AppColors.appCard,
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Colors.black.withOpacity(0.3),
//                           ),
//                         ),
//                         const Center(
//                           child: Icon(
//                             Icons.play_arrow_rounded,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 16),

//                 // Content
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => widget.onVideoSelect(video.id),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           video.title,
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(fontWeight: FontWeight.bold),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           video.subtitle ?? '',
//                           style: Theme.of(context).textTheme.bodySmall
//                               ?.copyWith(color: AppColors.textSecondary),
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Text(
//                               video.duration,
//                               style: Theme.of(context).textTheme.bodySmall
//                                   ?.copyWith(color: AppColors.textMuted),
//                             ),
//                             if (video.isDownloaded == true) ...[
//                               const SizedBox(width: 8),
//                               Text(
//                                 'Downloaded',
//                                 style: Theme.of(context).textTheme.bodySmall
//                                     ?.copyWith(color: AppColors.neonAccent),
//                               ),
//                             ],
//                             if ((video.downloadProgress ?? 0) > 0 &&
//                                 (video.downloadProgress ?? 0) < 100) ...[
//                               const SizedBox(width: 8),
//                               Text(
//                                 '${video.downloadProgress}%',
//                                 style: Theme.of(context).textTheme.bodySmall
//                                     ?.copyWith(color: AppColors.neonAccent),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Actions
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (video.isDownloaded != true &&
//                         (video.downloadProgress ?? 0) == 0)
//                       IconButton(
//                         onPressed: () => _handleDownload(video.id),
//                         icon: const Icon(
//                           Icons.download_for_offline_outlined,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),

//                     PopupMenuButton<String>(
//                       icon: const Icon(
//                         Icons.more_vert_rounded,
//                         color: AppColors.textPrimary,
//                       ),
//                       color: AppColors.appSurface,
//                       onSelected: (value) {
//                         switch (value) {
//                           case 'share':
//                             // Handle share
//                             break;
//                           case 'remove':
//                             _handleRemoveFromPlaylist(video.id);
//                             break;
//                         }
//                       },
//                       itemBuilder: (context) => [
//                         PopupMenuItem<String>(
//                           value: 'share',
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.share_outlined,
//                                 color: AppColors.textPrimary,
//                                 size: 20,
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'Share',
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                             ],
//                           ),
//                         ),
//                         PopupMenuItem<String>(
//                           value: 'remove',
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.delete_outline_rounded,
//                                 color: Colors.red,
//                                 size: 20,
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'Remove from playlist',
//                                 style: Theme.of(context).textTheme.bodyMedium
//                                     ?.copyWith(color: Colors.red),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             // Download Progress
//             if ((video.downloadProgress ?? 0) > 0 &&
//                 (video.downloadProgress ?? 0) < 100)
//               Padding(
//                 padding: const EdgeInsets.only(top: 12),
//                 child: LinearProgressIndicator(
//                   value: (video.downloadProgress ?? 0) / 100,
//                   backgroundColor: AppColors.textMuted.withOpacity(0.3),
//                   valueColor: const AlwaysStoppedAnimation<Color>(
//                     AppColors.neonAccent,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:audio_video_player/cores/theme/theme.dart';
import 'package:audio_video_player/features/model/video_model.dart';
import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  final Function(String) onVideoSelect;
  final VoidCallback onBack;

  const PlaylistScreen({
    super.key,
    required this.onVideoSelect,
    required this.onBack,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<VideoModel> _playlistVideos = [
    VideoModel(
      id: '1',
      title: 'The Matrix',
      subtitle: 'Action • Sci-Fi',
      duration: '2h 16m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://picsum.photos/id/1011/200/120',
      isDownloaded: true,
      downloadProgress: 100,
    ),
    VideoModel(
      id: '2',
      title: 'Blade Runner 2049',
      subtitle: 'Sci-Fi • Thriller',
      duration: '2h 44m',
      url:
          'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
      thumbnail: 'https://picsum.photos/id/1015/200/120',
      isDownloaded: false,
      downloadProgress: 0,
    ),
    VideoModel(
      id: '3',
      title: 'Ex Machina',
      subtitle: 'Sci-Fi • Drama',
      duration: '1h 48m',
      url:
          'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4',
      thumbnail: 'https://picsum.photos/id/1016/200/120',
      isDownloaded: true,
      downloadProgress: 100,
    ),
    VideoModel(
      id: '4',
      title: 'Interstellar',
      subtitle: 'Sci-Fi • Adventure',
      duration: '2h 49m',
      url: 'https://sample-videos.com/video123/mp4/720/sample-5s.mp4',
      thumbnail: 'https://picsum.photos/id/1021/200/120',
      isDownloaded: false,
      downloadProgress: 75,
    ),
    VideoModel(
      id: '5',
      title: 'Inception',
      subtitle: 'Action • Thriller',
      duration: '2h 28m',
      url: 'https://sample-videos.com/video123/mp4/720/sample-10s.mp4',
      thumbnail: 'https://picsum.photos/id/1025/200/120',
      isDownloaded: true,
      downloadProgress: 100,
    ),
  ];

  void _handleDownload(String videoId) {
    setState(() {
      final index = _playlistVideos.indexWhere((video) => video.id == videoId);
      if (index != -1) {
        final video = _playlistVideos[index];
        if (video.downloadProgress == 0) {
          _playlistVideos[index] = video.copyWith(downloadProgress: 25);
        }
      }
    });
  }

  void _handleRemoveFromPlaylist(String videoId) {
    setState(() {
      _playlistVideos.removeWhere((video) => video.id == videoId);
    });
  }

  int get _totalVideos => _playlistVideos.length;

  String get _totalDuration {
    int totalMinutes = 0;
    for (final video in _playlistVideos) {
      final parts = video.duration.split('h ');
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1].replaceAll('m', ''));
      totalMinutes += hours * 60 + minutes;
    }
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPlaylistHeader(),
            Expanded(child: _buildVideoList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Playlist',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '$_totalVideos videos • $_totalDuration',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.appSurface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.neonAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sci-Fi Collection',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your favorite sci-fi movies',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_playlistVideos.isNotEmpty) {
                        widget.onVideoSelect(
                          _playlistVideos.first.url,
                        ); // ✅ url পাঠানো হচ্ছে
                      }
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Play All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_for_offline_rounded),
                    label: const Text('Download All'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _playlistVideos.length,
      itemBuilder: (context, index) {
        final video = _playlistVideos[index];
        return _buildVideoItem(video);
      },
    );
  }

  Widget _buildVideoItem(VideoModel video) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.appSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => widget.onVideoSelect(
                video.url,
              ), // ✅ এখন id নয়, আসল url পাঠাবে
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  video.thumbnail,
                  width: 64,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onVideoSelect(video.url),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.subtitle ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          video.duration,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                        if (video.isDownloaded == true) ...[
                          const SizedBox(width: 8),
                          Text(
                            'Downloaded',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.neonAccent),
                          ),
                        ],
                        if ((video.downloadProgress ?? 0) > 0 &&
                            (video.downloadProgress ?? 0) < 100) ...[
                          const SizedBox(width: 8),
                          Text(
                            '${video.downloadProgress}%',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.neonAccent),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => _handleRemoveFromPlaylist(video.id),
              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
