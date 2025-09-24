import 'package:audio_video_player/cores/theme/theme.dart';
import 'package:audio_video_player/features/model/video_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onVideoSelect;
  final VoidCallback onNavigateToPlaylist;
  final VoidCallback onNavigateToProfile;

  const HomeScreen({
    super.key,
    required this.onVideoSelect,
    required this.onNavigateToPlaylist,
    required this.onNavigateToProfile,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'Action',
    'Drama',
    'Comedy',
    'Thriller',
    'Sci-Fi',
    'Horror',
  ];

  final VideoModel _featuredVideo = VideoModel(
    id: 'featured-1',
    title: 'The Dark Knight Returns',
    description: 'Batman faces his greatest challenge in this epic finale',
    url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    thumbnail: 'https://images.unsplash.com/photo-1679699316094-a74534381e22',
    duration: '2h 45m',
  );

  final List<VideoModel> _trendingVideos = [
    VideoModel(
      id: '1',
      title: 'Inception',
      duration: '2h 28m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1710988486821-9af47f60d62b',
    ),
    VideoModel(
      id: '2',
      title: 'Interstellar',
      duration: '2h 49m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1739891251370-05b62a54697b',
    ),
    VideoModel(
      id: '3',
      title: 'Dunkirk',
      duration: '1h 46m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1679699316094-a74534381e22',
    ),
    VideoModel(
      id: '4',
      title: 'Tenet',
      duration: '2h 30m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1710988486821-9af47f60d62b',
    ),
  ];

  final List<VideoModel> _myPlaylist = [
    VideoModel(
      id: '5',
      title: 'The Matrix',
      duration: '2h 16m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1739891251370-05b62a54697b',
    ),
    VideoModel(
      id: '6',
      title: 'Blade Runner',
      duration: '1h 57m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1679699316094-a74534381e22',
    ),
    VideoModel(
      id: '7',
      title: 'Ex Machina',
      duration: '1h 48m',
      url:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: 'https://images.unsplash.com/photo-1710988486821-9af47f60d62b',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Search Bar
            _buildSearchBar(),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Video
                    _buildFeaturedVideo(),

                    const SizedBox(height: 32),

                    // Categories
                    _buildCategories(),

                    const SizedBox(height: 32),

                    // My Playlist
                    _buildMyPlaylist(),

                    const SizedBox(height: 32),

                    // Trending
                    _buildTrending(),

                    const SizedBox(
                      height: 100,
                    ), // Bottom padding for navigation
                  ],
                ),
              ),
            ),
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.neonAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'VideoStream',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search movies, shows...',
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.appSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedVideo() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.appSurface, AppColors.appCard],
                ),
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),

            // Play Button
            Center(
              child: GestureDetector(
                onTap: () => widget.onVideoSelect(_featuredVideo.id),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.neonAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonAccent.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _featuredVideo.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _featuredVideo.description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          _featuredVideo.duration,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.neonAccent),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () =>
                              widget.onVideoSelect(_featuredVideo.id),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                          ),
                          child: const Text('Watch Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedCategoryIndex;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.neonAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.neonAccent
                            : AppColors.textMuted,
                      ),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.black
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMyPlaylist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.favorite_rounded,
              color: AppColors.neonAccent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'My Playlist',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: widget.onNavigateToPlaylist,
              child: const Text(
                'View All',
                style: TextStyle(color: AppColors.neonAccent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _myPlaylist.length,
            itemBuilder: (context, index) {
              return _buildVideoCard(_myPlaylist[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.trending_up_rounded,
              color: AppColors.neonAccent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Trending',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _trendingVideos.length,
            itemBuilder: (context, index) {
              return _buildVideoCard(_trendingVideos[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard(VideoModel video) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => widget.onVideoSelect(video.id),
        child: SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.appSurface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.appSurface,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          video.duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                video.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
