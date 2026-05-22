import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeContent extends StatelessWidget {
  const YoutubeContent({super.key, required this.videoId});

  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => context.push('/youtube-player', extra: videoId),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  YoutubePlayerController.getThumbnail(
                    videoId: videoId,
                    quality: .high,
                  ),
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : ColoredBox(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                  errorBuilder: (_, _, _) =>
                      ColoredBox(color: Theme.of(context).colorScheme.surface),
                ),

                Center(child: const _DefaultPlayIcon()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultPlayIcon extends StatelessWidget {
  const _DefaultPlayIcon();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(Icons.play_arrow, color: colorScheme.onPrimary, size: 32),
      ),
    );
  }
}
