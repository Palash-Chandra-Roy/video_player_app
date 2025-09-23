import 'package:audio_video_player/cores/theme/theme.dart';
import 'package:audio_video_player/features/auth/login/screen/login.dart';
import 'package:audio_video_player/features/home/screen/home_screen.dart';
import 'package:audio_video_player/features/onbording/screen/onbording.dart';
import 'package:audio_video_player/features/playlist/screen/playlist_screen.dart';
import 'package:audio_video_player/features/profile/screen/profile_screen.dart';
import 'package:audio_video_player/features/settings/screen/settings.dart';
import 'package:audio_video_player/features/splash/screen/splash_screen.dart';
import 'package:audio_video_player/features/video_player/screen/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const VideoPlayerApp());
}

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VideoStream',
      theme: AppTheme.darkTheme,
      home: const MainApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum AppScreen {
  splash,
  onboarding,
  login,
  home,
  videoPlayer,
  playlist,
  profile,
  settings,
}

enum BottomTab { home, playlist, profile }

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppScreen _currentScreen = AppScreen.splash;
  BottomTab _activeTab = BottomTab.home;
  String _selectedVideoId = '';
  bool _isLoggedIn = false;

  void _handleSplashComplete() {
    setState(() {
      _currentScreen = AppScreen.onboarding;
    });
  }

  void _handleOnboardingComplete() {
    setState(() {
      _currentScreen = AppScreen.login;
    });
  }

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
      _currentScreen = AppScreen.home;
    });
  }

  void _handleGuestLogin() {
    setState(() {
      _isLoggedIn = false;
      _currentScreen = AppScreen.home;
    });
  }

  void _handleVideoSelect(String videoId) {
    setState(() {
      _selectedVideoId = videoId;
      _currentScreen = AppScreen.videoPlayer;
    });
  }

  void _handleNavigateToHome() {
    setState(() {
      _activeTab = BottomTab.home;
      _currentScreen = AppScreen.home;
    });
  }

  void _handleNavigateToPlaylist() {
    setState(() {
      _activeTab = BottomTab.playlist;
      _currentScreen = AppScreen.playlist;
    });
  }

  void _handleNavigateToProfile() {
    setState(() {
      _activeTab = BottomTab.profile;
      _currentScreen = AppScreen.profile;
    });
  }

  void _handleNavigateToSettings() {
    setState(() {
      _currentScreen = AppScreen.settings;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _currentScreen = AppScreen.login;
    });
  }

  void _handleBackFromVideoPlayer() {
    setState(() {
      _currentScreen = AppScreen.home;
    });
  }

  void _handleTabChange(BottomTab tab) {
    setState(() {
      _activeTab = tab;
      switch (tab) {
        case BottomTab.home:
          _currentScreen = AppScreen.home;
          break;
        case BottomTab.playlist:
          _currentScreen = AppScreen.playlist;
          break;
        case BottomTab.profile:
          _currentScreen = AppScreen.profile;
          break;
      }
    });
  }

  bool get _showBottomNavigation => [
    AppScreen.home,
    AppScreen.playlist,
    AppScreen.profile,
  ].contains(_currentScreen);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF28273A),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF28273A),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            _buildCurrentScreen(),

            // Bottom Navigation
            if (_showBottomNavigation)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomNavigation(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreen) {
      case AppScreen.splash:
        return SplashScreen(onComplete: _handleSplashComplete);
      case AppScreen.onboarding:
        return OnboardingScreen(onComplete: _handleOnboardingComplete);
      case AppScreen.login:
        return LoginScreen(
          onLogin: _handleLogin,
          onGuestLogin: _handleGuestLogin,
        );
      case AppScreen.home:
        return HomeScreen(
          onVideoSelect: _handleVideoSelect,
          onNavigateToPlaylist: _handleNavigateToPlaylist,
          onNavigateToProfile: _handleNavigateToProfile,
        );
      case AppScreen.videoPlayer:
        return VideoPlayerScreen(
          videoId: _selectedVideoId,
          onBack: _handleBackFromVideoPlayer,
        );
      case AppScreen.playlist:
        return PlaylistScreen(
          onVideoSelect: _handleVideoSelect,
          onBack: _handleNavigateToHome,
        );
      case AppScreen.profile:
        return ProfileScreen(
          onBack: _handleNavigateToHome,
          onNavigateToSettings: _handleNavigateToSettings,
          onLogout: _handleLogout,
        );
      case AppScreen.settings:
        return SettingsScreen(
          onBack: _handleNavigateToProfile,
          onLogout: _handleLogout,
        );
    }
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E2E),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFD2FF57).withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                tab: BottomTab.home,
              ),
              _buildNavItem(
                icon: Icons.favorite_rounded,
                label: 'Playlist',
                tab: BottomTab.playlist,
              ),
              _buildNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                tab: BottomTab.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required BottomTab tab,
  }) {
    final isActive = _activeTab == tab;

    return GestureDetector(
      onTap: () => _handleTabChange(tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2D2C40) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFFD2FF57)
                  : const Color(0xFF717182),
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFFD2FF57)
                    : const Color(0xFF717182),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
