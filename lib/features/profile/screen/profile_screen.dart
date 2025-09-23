import 'package:audio_video_player/cores/theme/theme.dart';
import 'package:audio_video_player/features/model/video_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNavigateToSettings;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.onBack,
    required this.onNavigateToSettings,
    required this.onLogout,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<VideoModel> _recentlyWatched = [
    VideoModel(
      id: '1',
      title: 'The Matrix',
      duration: '2h 16m',
      thumbnail: 'https://images.unsplash.com/photo-1739891251370-05b62a54697b',
      downloadProgress: 85,
    ),
    VideoModel(
      id: '2',
      title: 'Blade Runner',
      duration: '1h 57m',
      thumbnail: 'https://images.unsplash.com/photo-1679699316094-a74534381e22',
      downloadProgress: 42,
    ),
    VideoModel(
      id: '3',
      title: 'Ex Machina',
      duration: '1h 48m',
      thumbnail: 'https://images.unsplash.com/photo-1710988486821-9af47f60d62b',
      downloadProgress: 100,
    ),
  ];

  final List<Map<String, dynamic>> _downloads = [
    {'title': 'The Matrix', 'size': '2.1 GB', 'status': 'completed'},
    {'title': 'Ex Machina', 'size': '1.8 GB', 'status': 'completed'},
    {'title': 'Inception', 'size': '2.3 GB', 'status': 'downloading'},
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {
      'icon': Icons.history_rounded,
      'title': 'Watch History',
      'subtitle': 'View your recently watched videos',
    },
    {
      'icon': Icons.download_for_offline_rounded,
      'title': 'Downloads',
      'subtitle': 'Manage your offline videos',
    },
    {
      'icon': Icons.settings_rounded,
      'title': 'Settings',
      'subtitle': 'App preferences and account settings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info
                    _buildUserInfo(),

                    const SizedBox(height: 24),

                    // Recently Watched
                    _buildRecentlyWatched(),

                    const SizedBox(height: 24),

                    // Downloads
                    _buildDownloads(),

                    const SizedBox(height: 24),

                    // Menu Items
                    _buildMenuItems(),

                    const SizedBox(height: 24),

                    // Logout
                    _buildLogout(),

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
          IconButton(
            onPressed: widget.onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Profile',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.appSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.neonAccent,
                child: const Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Johnson',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'alex.johnson@email.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Premium Member',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.neonAccent,
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
              Expanded(child: _buildStatItem('47', 'Videos Watched')),
              Expanded(child: _buildStatItem('12', 'Downloads')),
              Expanded(child: _buildStatItem('156h', 'Watch Time')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRecentlyWatched() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.history_rounded,
              color: AppColors.neonAccent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Recently Watched',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: _recentlyWatched.map((video) {
            return _buildRecentlyWatchedItem(video);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentlyWatchedItem(VideoModel video) {
    final progress = video.downloadProgress ?? 0;

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
            Container(
              width: 64,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.appCard,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            '$progress%',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.neonAccent),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: progress / 100,
                        backgroundColor: AppColors.textMuted.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.neonAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloads() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.storage_rounded,
              color: AppColors.neonAccent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Downloads',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: _downloads.map((download) {
            return _buildDownloadItem(download);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDownloadItem(Map<String, dynamic> download) {
    final isCompleted = download['status'] == 'completed';

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    download['title'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    download['size'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.neonAccent.withOpacity(0.2)
                    : Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isCompleted ? 'Downloaded' : 'Downloading...',
                style: TextStyle(
                  color: isCompleted ? AppColors.neonAccent : Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: _menuItems.map((item) {
        return _buildMenuItem(
          icon: item['icon'],
          title: item['title'],
          subtitle: item['subtitle'],
          onTap: () {
            if (item['title'] == 'Settings') {
              widget.onNavigateToSettings();
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.appSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.appCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.neonAccent, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogout() {
    return Column(
      children: [
        const Divider(color: AppColors.textMuted),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: widget.onLogout,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.appSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Logout',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sign out of your account',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
