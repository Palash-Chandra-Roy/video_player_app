import 'package:audio_video_player/cores/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onLogout;

  const SettingsScreen({
    super.key,
    required this.onBack,
    required this.onLogout,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = true;
  bool _notifications = true;
  bool _autoDownload = false;
  String _playbackSpeed = '1x';
  String _subtitleLanguage = 'english';
  String _downloadQuality = 'hd';

  final Map<String, dynamic> _storageInfo = {
    'used': 4.2,
    'total': 64,
    'downloads': 12,
  };

  late final List<Map<String, dynamic>> _settingSections;

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  void _initializeSettings() {
    _settingSections = [
      {
        'title': 'Appearance',
        'items': [
          {
            'icon': Icons.dark_mode_rounded,
            'title': 'Dark Mode',
            'subtitle': 'Use dark theme for better viewing experience',
            'type': 'switch',
            'value': _darkMode,
            'onChanged': (bool value) {
              setState(() {
                _darkMode = value;
              });
            },
          },
        ],
      },
      {
        'title': 'Notifications',
        'items': [
          {
            'icon': Icons.notifications_rounded,
            'title': 'Push Notifications',
            'subtitle': 'Get notified about new releases and updates',
            'type': 'switch',
            'value': _notifications,
            'onChanged': (bool value) {
              setState(() {
                _notifications = value;
              });
            },
          },
        ],
      },
      {
        'title': 'Playback',
        'items': [
          {
            'icon': Icons.speed_rounded,
            'title': 'Playback Speed',
            'subtitle': 'Default video playback speed',
            'type': 'dropdown',
            'value': _playbackSpeed,
            'options': [
              {'value': '0.5x', 'label': '0.5x'},
              {'value': '0.75x', 'label': '0.75x'},
              {'value': '1x', 'label': 'Normal (1x)'},
              {'value': '1.25x', 'label': '1.25x'},
              {'value': '1.5x', 'label': '1.5x'},
              {'value': '2x', 'label': '2x'},
            ],
            'onChanged': (String value) {
              setState(() {
                _playbackSpeed = value;
              });
            },
          },
          {
            'icon': Icons.subtitles_rounded,
            'title': 'Subtitle Language',
            'subtitle': 'Default subtitle language preference',
            'type': 'dropdown',
            'value': _subtitleLanguage,
            'options': [
              {'value': 'english', 'label': 'English'},
              {'value': 'spanish', 'label': 'Spanish'},
              {'value': 'french', 'label': 'French'},
              {'value': 'german', 'label': 'German'},
              {'value': 'off', 'label': 'Off'},
            ],
            'onChanged': (String value) {
              setState(() {
                _subtitleLanguage = value;
              });
            },
          },
        ],
      },
      {
        'title': 'Downloads',
        'items': [
          {
            'icon': Icons.download_for_offline_rounded,
            'title': 'Auto Download',
            'subtitle': 'Automatically download videos for offline viewing',
            'type': 'switch',
            'value': _autoDownload,
            'onChanged': (bool value) {
              setState(() {
                _autoDownload = value;
              });
            },
          },
          {
            'icon': Icons.hd_rounded,
            'title': 'Download Quality',
            'subtitle': 'Video quality for downloaded content',
            'type': 'dropdown',
            'value': _downloadQuality,
            'options': [
              {'value': 'sd', 'label': 'SD (480p)'},
              {'value': 'hd', 'label': 'HD (720p)'},
              {'value': 'fhd', 'label': 'Full HD (1080p)'},
              {'value': 'auto', 'label': 'Auto (based on connection)'},
            ],
            'onChanged': (String value) {
              setState(() {
                _downloadQuality = value;
              });
            },
          },
        ],
      },
    ];
  }

  double get _usagePercentage =>
      (_storageInfo['used'] / _storageInfo['total']) * 100;

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
                    // Storage Info
                    _buildStorageInfo(),

                    const SizedBox(height: 24),

                    // Settings Sections
                    ..._settingSections.map(
                      (section) => _buildSettingsSection(section),
                    ),

                    // Account Section
                    _buildAccountSection(),

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
            'Settings',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageInfo() {
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.neonAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.storage_rounded,
                  color: AppColors.neonAccent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Storage',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_storageInfo['used']} GB of ${_storageInfo['total']} GB used',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_storageInfo['downloads']} downloads',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_usagePercentage.toStringAsFixed(1)}% used',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(
            value: _usagePercentage / 100,
            backgroundColor: AppColors.textMuted.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.neonAccent,
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton(onPressed: () {}, child: const Text('Manage Storage')),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(Map<String, dynamic> section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section['title'],
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            children: (section['items'] as List).map<Widget>((item) {
              return _buildSettingItem(item);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
              child: Icon(item['icon'], color: AppColors.neonAccent, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            _buildSettingControl(item),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingControl(Map<String, dynamic> item) {
    switch (item['type']) {
      case 'switch':
        return Switch(
          value: item['value'],
          onChanged: item['onChanged'],
          activeColor: AppColors.neonAccent,
        );
      case 'dropdown':
        return DropdownButton<String>(
          value: item['value'],
          onChanged: item['onChanged'],
          underline: const SizedBox(),
          dropdownColor: AppColors.appSurface,
          style: Theme.of(context).textTheme.bodyMedium,
          items: (item['options'] as List).map<DropdownMenuItem<String>>((
            option,
          ) {
            return DropdownMenuItem<String>(
              value: option['value'],
              child: Text(
                option['label'],
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            );
          }).toList(),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildAccountSection() {
    final accountItems = [
      {
        'icon': Icons.privacy_tip_rounded,
        'title': 'Privacy Policy',
        'subtitle': 'Read our privacy policy',
      },
      {
        'icon': Icons.description_rounded,
        'title': 'Terms of Service',
        'subtitle': 'View terms and conditions',
      },
      {
        'icon': Icons.info_rounded,
        'title': 'About',
        'subtitle': 'App version and information',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Column(
            children: accountItems.map((item) {
              return _buildAccountItem(item);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {},
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
                child: Icon(
                  item['icon'],
                  color: AppColors.neonAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['subtitle'],
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
