import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({super.key, required this.videoId});

  final String videoId;

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late final _controller = YoutubePlayerController.fromVideoId(
    videoId: widget.videoId,
    autoPlay: true,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AdaptiveAppBar(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: YoutubePlayer(controller: _controller, autoFullScreen: false),
      ),
    );
  }
}
