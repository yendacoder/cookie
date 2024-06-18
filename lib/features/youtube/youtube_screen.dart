import 'package:auto_route/auto_route.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen(
      {super.key, @PathParam() required this.videoId, this.url});

  final String videoId;
  final String? url;

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PlatformScaffold(
        backgroundColor: Colors.black87,
        appBar: FlatAppBar(
          trailingActions: [
            if (widget.url != null)
              PlatformIconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => launchUrlString(widget.url!,
                      mode: LaunchMode.externalApplication))
          ],
        ),
        body: SizedBox.expand(
            child: Center(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: theme.colorScheme.secondary,
              progressColors: ProgressBarColors(
                playedColor: theme.colorScheme.primary,
                handleColor: theme.colorScheme.secondary,
              ),
            ),
            builder: (context, player) => player,
          ),
        )));
  }
}
