import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/error_view.dart';
import '../../../models/user_list.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/widgets/auth_gate.dart';
import '../providers/user_lists_provider.dart';
import '../widgets/list_form_sheet.dart';

class ListsScreen extends ConsumerWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.listsScreenTitle),
      ),
      body: AuthGate(child: _ListsBody()),
      floatingActionButton: _CreateFab(),
    );
  }
}

// ── FAB ───────────────────────────────────────────────────────────────────────

class _CreateFab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated =
        ref.watch(authProvider.select((s) => s.value != null));
    if (!isAuthenticated) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: () => _showCreateSheet(context, ref),
      tooltip: context.l10n.listsCreateTitle,
      child: const Icon(Icons.add),
    );
  }
}

void _showCreateSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => ListFormSheet(
      onSave: ({
        required name,
        required displayName,
        description,
        required public,
      }) =>
          ref.read(userListsProvider.notifier).create(
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
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
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

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userListsProvider);
        await ref.read(userListsProvider.future);
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: lists.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) =>
            _ListTile(list: lists[index]),
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

    return ListTile(
      leading: Icon(
        list.public ? Icons.bookmark_outlined : Icons.lock_outline,
        color: colorScheme.onSurfaceVariant,
      ),
      title: Text(list.displayName),
      subtitle: Text(context.l10n.listItemCount(list.numItems)),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: context.l10n.listsDeleteTooltip,
        onPressed: () => _confirmDelete(context, ref),
      ),
      onTap: () => context.push('/lists/${list.id}', extra: list),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(ctx.l10n.listsDeleteConfirmTitle),
        content: Text(ctx.l10n.listsDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.cancelButton),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.errorGeneric)),
          );
        }
      }
    }
  }
}
