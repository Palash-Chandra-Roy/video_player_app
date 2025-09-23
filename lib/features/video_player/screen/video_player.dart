import 'package:audio_video_player/cores/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final VoidCallback onBack;

  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.onBack,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  double _currentTime = 0;
  final double _duration = 180; // 3 minutes for demo
  double _volume = 80;
  bool _isMuted = false;
  bool _isFullscreen = false;
  bool _showControls = true;
  Timer? _hideControlsTimer;
  Timer? _playbackTimer;

  @override
  void initState() {
    super.initState();
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _playbackTimer?.cancel();
    super.dispose();
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (_isPlaying && mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _showControlsTemporarily() {
    setState(() {
      _showControls = true;
    });
    _startHideControlsTimer();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            _currentTime = (_currentTime + 1).clamp(0, _duration);
            if (_currentTime >= _duration) {
              _isPlaying = false;
              timer.cancel();
            }
          });
        }
      });
    } else {
      _playbackTimer?.cancel();
    }

    _showControlsTemporarily();
  }

  void _seekTo(double value) {
    setState(() {
      _currentTime = value;
    });
    _showControlsTemporarily();
  }

  void _skipBackward() {
    setState(() {
      _currentTime = (_currentTime - 10).clamp(0, _duration);
    });
    _showControlsTemporarily();
  }

  void _skipForward() {
    setState(() {
      _currentTime = (_currentTime + 10).clamp(0, _duration);
    });
    _showControlsTemporarily();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _showControlsTemporarily();
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value;
      _isMuted = false;
    });
    _showControlsTemporarily();
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    _showControlsTemporarily();
  }

  String _formatTime(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).floor();
    return '${minutes}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header (only when not fullscreen)
            if (!_isFullscreen) _buildHeader(),

            // Video Player
            Expanded(child: _buildVideoPlayer()),

            // Video Info (only when not fullscreen)
            if (!_isFullscreen) _buildVideoInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.appBackground,
      padding: const EdgeInsets.all(16),
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
            'The Dark Knight Returns',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_rounded,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return GestureDetector(
      onTap: _showControlsTemporarily,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            // Video placeholder
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[800]!, Colors.grey[900]!],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Video Player Demo',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            // Controls Overlay
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Top Controls (only in fullscreen)
                    if (_isFullscreen)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: widget.onBack,
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'The Dark Knight Returns',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.settings_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Center Play Button
                    Center(
                      child: GestureDetector(
                        onTap: _togglePlay,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Bottom Controls
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Progress Bar
                            Column(
                              children: [
                                Slider(
                                  value: _currentTime,
                                  max: _duration,
                                  onChanged: _seekTo,
                                  activeColor: AppColors.neonAccent,
                                  inactiveColor: Colors.white.withOpacity(0.3),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _formatTime(_currentTime),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatTime(_duration),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Control Buttons
                            Row(
                              children: [
                                // Left Controls
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: _skipBackward,
                                      icon: const Icon(
                                        Icons.replay_10_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _togglePlay,
                                      icon: Icon(
                                        _isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _skipForward,
                                      icon: const Icon(
                                        Icons.forward_10_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),

                                const Spacer(),

                                // Right Controls
                                Row(
                                  children: [
                                    // Volume
                                    IconButton(
                                      onPressed: _toggleMute,
                                      icon: Icon(
                                        _isMuted || _volume == 0
                                            ? Icons.volume_off_rounded
                                            : Icons.volume_up_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: Slider(
                                        value: _isMuted ? 0 : _volume,
                                        max: 100,
                                        onChanged: _setVolume,
                                        activeColor: AppColors.neonAccent,
                                        inactiveColor: Colors.white.withOpacity(
                                          0.3,
                                        ),
                                      ),
                                    ),

                                    // Subtitles
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.subtitles_outlined,
                                        color: Colors.white,
                                      ),
                                    ),

                                    // Fullscreen
                                    IconButton(
                                      onPressed: _toggleFullscreen,
                                      icon: Icon(
                                        _isFullscreen
                                            ? Icons.fullscreen_exit_rounded
                                            : Icons.fullscreen_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      color: AppColors.appBackground,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Dark Knight Returns',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Batman faces his greatest challenge in this epic finale to Christopher Nolan\'s trilogy.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '2012',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(width: 8),
              const Text('•', style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(width: 8),
              Text(
                '2h 45m',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(width: 8),
              const Text('•', style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.appSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'HD',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.neonAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
