import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/error_view.dart';
import '../../../models/community.dart';
import '../providers/community_provider.dart';

class ModToolsScreen extends ConsumerWidget {
  const ModToolsScreen({super.key, required this.communityName});

  final String communityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityAsync = ref.watch(communityDetailProvider(communityName));
    final l10n = context.l10n;

    // Keep showing content during background refreshes — only gate on initial load.
    if (communityAsync.value == null) {
      if (communityAsync.isLoading) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.modToolsScreenTitle)),
          body: const Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
        appBar: AppBar(title: Text(l10n.modToolsScreenTitle)),
        body: ErrorView(
          error: communityAsync.error!,
          onRetry: () => ref.invalidate(communityDetailProvider(communityName)),
        ),
      );
    }

    final community = communityAsync.value!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.modToolsScreenTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.modToolsTabSettings),
              Tab(text: l10n.modToolsTabRules),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _MetaTab(community: community, communityName: communityName),
            _RulesTab(community: community, communityName: communityName),
          ],
        ),
      ),
    );
  }
}

// ── Settings tab ──────────────────────────────────────────────────────────────

class _MetaTab extends ConsumerStatefulWidget {
  const _MetaTab({required this.community, required this.communityName});

  final Community community;
  final String communityName;

  @override
  ConsumerState<_MetaTab> createState() => _MetaTabState();
}

class _MetaTabState extends ConsumerState<_MetaTab> {
  late final TextEditingController _aboutCtrl;
  late bool _nsfw;
  late bool _postingRestricted;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _aboutCtrl = TextEditingController(text: widget.community.about ?? '');
    _nsfw = widget.community.nsfw;
    _postingRestricted = widget.community.postingRestricted;
  }

  @override
  void didUpdateWidget(_MetaTab old) {
    super.didUpdateWidget(old);
    if (old.community != widget.community) {
      _aboutCtrl.text = widget.community.about ?? '';
      _nsfw = widget.community.nsfw;
      _postingRestricted = widget.community.postingRestricted;
    }
  }

  @override
  void dispose() {
    _aboutCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final about = _aboutCtrl.text.trim();
      final res = await ref.read(apiClientProvider).put(
        'communities/${widget.community.id}',
        queryParameters: {'byName': 'true'},
        data: {
          'nsfw': _nsfw,
          'about': about.isEmpty ? null : about,
          'postingRestricted': _postingRestricted,
        },
      );
      final updated = Community.fromJson(res.data as Map<String, dynamic>);
      ref
          .read(communityDetailProvider(widget.communityName).notifier)
          .replace(updated);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.modToolsSaved)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _aboutCtrl,
          decoration: InputDecoration(
            labelText: l10n.modToolsDescriptionLabel,
            hintText: l10n.modToolsDescriptionHint,
            border: const OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 8,
          minLines: 3,
          textCapitalization: TextCapitalization.sentences,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.modToolsNsfwLabel),
          value: _nsfw,
          onChanged: (v) => setState(() => _nsfw = v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.modToolsPostingRestrictedLabel),
          value: _postingRestricted,
          onChanged: (v) => setState(() => _postingRestricted = v),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.saveButton),
        ),
      ],
    );
  }
}

// ── Rules tab ─────────────────────────────────────────────────────────────────

class _RulesTab extends ConsumerStatefulWidget {
  const _RulesTab({required this.community, required this.communityName});

  final Community community;
  final String communityName;

  @override
  ConsumerState<_RulesTab> createState() => _RulesTabState();
}

class _RulesTabState extends ConsumerState<_RulesTab> {
  late List<CommunityRule> _rules;
  bool _reordering = false;

  @override
  void initState() {
    super.initState();
    _rules = _sorted(widget.community.rules);
  }

  @override
  void didUpdateWidget(_RulesTab old) {
    super.didUpdateWidget(old);
    if (old.community.rules != widget.community.rules) {
      setState(() => _rules = _sorted(widget.community.rules));
    }
  }

  List<CommunityRule> _sorted(List<CommunityRule> rules) =>
      List.of(rules)..sort((a, b) => a.zIndex.compareTo(b.zIndex));

  void _pushRules(List<CommunityRule> rules) {
    ref
        .read(communityDetailProvider(widget.communityName).notifier)
        .replace(widget.community.copyWith(rules: rules));
  }

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex--;
    if (_reordering) return;

    final reordered = List<CommunityRule>.of(_rules);
    reordered.insert(newIndex, reordered.removeAt(oldIndex));

    setState(() {
      _rules = reordered;
      _reordering = true;
    });
    _pushRules(reordered);

    try {
      final api = ref.read(apiClientProvider);
      for (int i = 0; i < reordered.length; i++) {
        if (reordered[i].zIndex != i) {
          await api.put(
            'communities/${widget.community.id}/rules/${reordered[i].id}',
            data: {'zIndex': i},
          );
          reordered[i] = reordered[i].copyWith(zIndex: i);
        }
      }
      _pushRules(reordered);
    } catch (e) {
      // Revert to the pre-reorder order.
      if (mounted) {
        setState(() => _rules = _sorted(widget.community.rules));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _reordering = false);
    }
  }

  Future<void> _deleteRule(CommunityRule rule) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.modToolsDeleteRuleTitle),
        content: Text(l10n.modToolsDeleteRuleConfirm),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(false),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () => ctx.pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      await ref.read(apiClientProvider).delete(
        'communities/${widget.community.id}/rules/${rule.id}',
      );
      final updated = _rules.where((r) => r.id != rule.id).toList();
      setState(() => _rules = updated);
      _pushRules(updated);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _showRuleSheet([CommunityRule? existing]) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _RuleSheet(
        communityId: widget.community.id,
        existing: existing,
        onSaved: (rule) {
          final updated = existing != null
              ? _rules.map((r) => r.id == rule.id ? rule : r).toList()
              : _sorted([..._rules, rule]);
          setState(() => _rules = updated);
          _pushRules(updated);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    if (_rules.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.modToolsNoRules,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _showRuleSheet(),
              icon: const Icon(Icons.add),
              label: Text(l10n.modToolsAddRule),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        ReorderableListView.builder(
          padding: const EdgeInsets.only(bottom: 88),
          itemCount: _rules.length,
          onReorder: _onReorder,
          itemBuilder: (_, i) {
            final rule = _rules[i];
            return ListTile(
              key: ValueKey(rule.id),
              title: Text('${i + 1}. ${rule.rule}'),
              subtitle: (rule.description?.isNotEmpty ?? false)
                  ? Text(
                      rule.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _showRuleSheet(rule),
                    tooltip: context.l10n.communityRulesTitle,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: colorScheme.error),
                    onPressed: () => _deleteRule(rule),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            heroTag: 'mod-tools-add-rule',
            onPressed: () => _showRuleSheet(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

// ── Rule add / edit sheet ─────────────────────────────────────────────────────

class _RuleSheet extends ConsumerStatefulWidget {
  const _RuleSheet({
    required this.communityId,
    this.existing,
    required this.onSaved,
  });

  final String communityId;
  final CommunityRule? existing;
  final void Function(CommunityRule rule) onSaved;

  @override
  ConsumerState<_RuleSheet> createState() => _RuleSheetState();
}

class _RuleSheetState extends ConsumerState<_RuleSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _ruleCtrl;
  late final TextEditingController _descCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _ruleCtrl = TextEditingController(text: widget.existing?.rule ?? '');
    _descCtrl = TextEditingController(text: widget.existing?.description ?? '');
  }

  @override
  void dispose() {
    _ruleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    try {
      final api = ref.read(apiClientProvider);
      final body = {
        'rule': _ruleCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
      };
      final res = widget.existing != null
          ? await api.put(
              'communities/${widget.communityId}/rules/${widget.existing!.id}',
              data: body,
            )
          : await api.post(
              'communities/${widget.communityId}/rules',
              data: body,
            );
      final rule = CommunityRule.fromJson(res.data as Map<String, dynamic>);
      widget.onSaved(rule);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              widget.existing != null
                  ? l10n.modToolsEditRuleTitle
                  : l10n.modToolsNewRuleTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(height: 1),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _ruleCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.modToolsRuleLabel,
                      border: const OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty)
                            ? l10n.modToolsRuleRequired
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.modToolsRuleDescriptionLabel,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _saving ? null : _submit,
                    child: _saving
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.saveButton),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
