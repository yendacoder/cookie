import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key, this.community});

  final Community? community;

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _post(BuildContext context) async {
    if (_titleController.text.isEmpty) {
      return;
    }
    try {
      setState(() {
        _isSaving = true;
      });
      final controller = Provider.of<InitialController>(context, listen: false);
      final post = await controller.addPost(
          widget.community?.name ?? kDefaultCommunityName,
          _titleController.text,
          _bodyController.text);
      if (mounted && post != null) {
        context.router.replace(PostRoute(postId: post.publicId, post: post));
      }
    } catch (e) {
      showApiErrorMessage(context, e);
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PlatformScaffold(
        appBar: FlatAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPrimaryPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    if (widget.community != null) ...[
                      CommunityIcon(image: widget.community?.proPic),
                      const SizedBox(
                        width: 6.0,
                      ),
                    ],
                    Text('In ${widget.community?.name ?? kDefaultCommunityName}'),
                  ],
                ),
                const SizedBox(
                  height: kSecondaryPadding,
                ),
                PlatformTextField(
                  hintText: 'Title',
                  controller: _titleController,
                ),
                const SizedBox(
                  height: kSecondaryPadding,
                ),
                PlatformTextField(
                  hintText: 'Text or link (optional)',
                  controller: _bodyController,
                  minLines: 10,
                  maxLines: 10000,
                ),
                const SizedBox(
                  height: kSecondaryPadding,
                ),
                if (_isSaving)
                  Center(
                    child: PlatformCircularProgressIndicator(),
                  )
                else
                  PlatformElevatedButton(
                    onPressed: () => _post(context),
                    child: Text('Post'),
                  ),
                const SizedBox(
                  height: kSecondaryPadding,
                ),
                Text(
                  'Markdown cheatsheet:\nHeading: # heading\nBold: **bold**\nItalic: *italic*\nLink: [link](https://example.com)\nQuote: > quote\nCode: `code`',
                  style: theme.textTheme.bodyMedium!.copyWith(height: 2.0),
                )
              ],
            ),
          ),
        ));
  }
}
