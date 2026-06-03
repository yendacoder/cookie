import 'package:cookie/core/widgets/adaptive/adaptive_fab.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_refresh_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_sheet.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/models/user_list.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/auth/widgets/auth_gate.dart';
import 'package:cookie/features/lists/providers/user_lists_provider.dart';
import 'package:cookie/features/lists/widgets/list_form_sheet.dart';

class ListsScreen extends ConsumerWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: Text(context.l10n.listsScreenTitle)),
      body: AuthGate(child: _ListsBody()),
      floatingActionButton: _CreateFab(),
    );
  }
}

// ── FAB ───────────────────────────────────────────────────────────────────────

class _CreateFab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(
      authProvider.select((s) => s.value != null),
    );
    if (!isAuthenticated) return const SizedBox.shrink();

    return AdaptiveFab(
      onPressed: () => _showCreateSheet(context, ref),
      icon: Icons.add,
      tooltip: context.l10n.listsCreateTitle,
    );
  }
}

void _showCreateSheet(BuildContext context, WidgetRef ref) {
  showPlatformSheet(
    context: context,
    builder: (_) => ListFormSheet(
      onSave:
          ({
            required name,
            required displayName,
            description,
            required public,
          }) => ref
              .read(userListsProvider.notifier)
              .create(
                name: name,
                displayName: displayName,
                description: description,
                public: public,
              ),
    ),
  );
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _ListsBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsState = ref.watch(userListsProvider);

    return switch (listsState) {
      AsyncLoading() => const Center(child: AdaptiveProgressIndicator()),
      AsyncError(:final error) => ErrorView(
        error: error,
        onRetry: () => ref.invalidate(userListsProvider),
      ),
      AsyncData(:final value) => _ListsLoaded(lists: value),
    };
  }
}

class _ListsLoaded extends ConsumerWidget {
  const _ListsLoaded({required this.lists});

  final List<UserList> lists;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (lists.isEmpty) {
      return Center(
        child: Text(
          context.l10n.listsEmpty,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return AdaptiveRefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userListsProvider);
        await ref.read(userListsProvider.future);
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverList.separated(
            itemCount: lists.length,
            separatorBuilder: (_, _) => const AdaptiveDivider(height: 1),
            itemBuilder: (context, index) => _ListTile(list: lists[index]),
          ),
        ],
      ),
    );
  }
}

// ── List tile ─────────────────────────────────────────────────────────────────

class _ListTile extends ConsumerWidget {
  const _ListTile({required this.list});

  final UserList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return AdaptiveListTile(
      leading: Icon(
        list.public ? context.bookmarkIcon : Icons.lock_outline,
        color: colorScheme.onSurfaceVariant,
      ),
      title: Text(list.displayName),
      subtitle: Text(context.l10n.listItemCount(list.numItems)),
      trailing: IconButton(
        icon: Icon(context.deleteIcon),
        tooltip: context.l10n.listsDeleteTooltip,
        onPressed: () => _confirmDelete(context, ref),
      ),
      onTap: () => context.push('/lists/${list.id}', extra: list),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => AdaptiveAlertDialog(
        title: Text(ctx.l10n.listsDeleteConfirmTitle),
        content: Text(ctx.l10n.listsDeleteConfirmBody),
        actions: [
          AdaptiveDialogAction(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.cancelButton),
          ),
          AdaptiveDialogAction(
            isDefault: true,
            isDestructive: true,
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ctx.l10n.listsDeleteConfirmTitle),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await ref.read(userListsProvider.notifier).delete(list.id);
      } catch (_) {
        if (context.mounted) {
          showPlatformSnackBar(context, context.l10n.errorGeneric);
        }
      }
    }
  }
}
