import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet_header.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../core/providers/platform_style_provider.dart';
import '../../../core/widgets/adaptive/adaptive_progress_indicator.dart';
import '../../../models/post.dart';
import '../../lists/providers/user_lists_provider.dart';

class PostSaveToListSheet extends ConsumerStatefulWidget {
  const PostSaveToListSheet({super.key, required this.post});

  final Post post;

  @override
  ConsumerState<PostSaveToListSheet> createState() =>
      _PostSaveToListSheetState();
}

class _PostSaveToListSheetState extends ConsumerState<PostSaveToListSheet> {
  int? _savingListId;

  Future<void> _saveTo(int listId, String listDisplayName) async {
    setState(() => _savingListId = listId);
    try {
      await ref.read(apiClientProvider).post(
        'lists/$listId/items',
        data: {'targetId': widget.post.id, 'targetType': 'post'},
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      showPlatformSnackBar(context, context.l10n.postSavedToList(listDisplayName));
    } catch (_) {
      if (mounted) setState(() => _savingListId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listsState = ref.watch(userListsProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          AdaptiveSheetHeader(title: context.l10n.postMenuSaveToList),
          switch (listsState) {
            AsyncLoading() => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: AdaptiveProgressIndicator()),
              ),
            AsyncError() => Padding(
                padding: const EdgeInsets.all(16),
                child: Text(context.l10n.errorGeneric),
              ),
            AsyncData(:final value) when value.isEmpty => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.listsEmpty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    AdaptiveTextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.push('/lists');
                      },
                      child: Text(context.l10n.listsCreateTitle),
                    ),
                  ],
                ),
              ),
            AsyncData(:final value) => ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * 0.5,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: value.length,
                  separatorBuilder: (_, _) => const AdaptiveDivider(height: 1),
                  itemBuilder: (context, index) {
                    final list = value[index];
                    final saving = _savingListId == list.id;
                    return AdaptiveListTile(
                      leading: Icon(
                        list.public
                            ? context.bookmarkIcon
                            : Icons.lock_outline,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      title: Text(list.displayName),
                      subtitle: Text(context.l10n.listItemCount(list.numItems)),
                      trailing: saving
                          ? const SizedBox.square(
                              dimension: 20,
                              child: AdaptiveProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                      onTap: saving
                          ? null
                          : () => _saveTo(list.id, list.displayName),
                    );
                  },
                ),
              ),
          },
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
