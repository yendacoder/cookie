import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../models/user_list.dart';

/// Bottom sheet form for creating or editing a [UserList].
///
/// Pass [initial] to pre-fill fields for edit mode.
/// [onSave] receives the validated field values.
class ListFormSheet extends StatefulWidget {
  const ListFormSheet({
    super.key,
    this.initial,
    required this.onSave,
  });

  final UserList? initial;
  final Future<void> Function({
    required String name,
    required String displayName,
    String? description,
    required bool public,
  }) onSave;

  @override
  State<ListFormSheet> createState() => _ListFormSheetState();
}

class _ListFormSheetState extends State<ListFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _displayNameCtrl;
  late final TextEditingController _descriptionCtrl;
  late bool _public;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _displayNameCtrl =
        TextEditingController(text: widget.initial?.displayName ?? '');
    _descriptionCtrl =
        TextEditingController(text: widget.initial?.description ?? '');
    _public = widget.initial?.public ?? false;
  }

  @override
  void dispose() {
    _displayNameCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  String _toSlug(String displayName) => displayName
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), '-')
      .replaceAll(RegExp(r'[^a-z0-9-]'), '')
      .replaceAll(RegExp(r'-{2,}'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    try {
      final displayName = _displayNameCtrl.text.trim();
      await widget.onSave(
        name: widget.initial?.name ?? _toSlug(displayName),
        displayName: displayName,
        description: _descriptionCtrl.text.trim().isEmpty
            ? null
            : _descriptionCtrl.text.trim(),
        public: _public,
      );
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isEdit = widget.initial != null;

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
              isEdit ? l10n.listsEditTitle : l10n.listsCreateTitle,
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
                    controller: _displayNameCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.listsDisplayNameLabel,
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l10n.listsDisplayNameRequired
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.listsDescriptionLabel,
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.listsPublicToggle),
                    value: _public,
                    onChanged: (v) => setState(() => _public = v),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _saving ? null : _submit,
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
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
