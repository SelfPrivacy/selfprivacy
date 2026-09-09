import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/forms/ssh_key_form_view.dart';
import 'package:selfprivacy/ui/molecules/cards/radio_selection_card.dart';
import 'fixtures.dart';

enum PreviewAction {
  reveal,
  expand,
  invalidInput,
  validKey,
  invalidKey,
  chipDialog,
  deviceDialog,
  inplaceRestore,
  deselectBackups,
  copyKey,
}

class PreparedPreview extends StatefulWidget {
  const PreparedPreview({required this.action, required this.child, super.key});
  final PreviewAction action;
  final Widget child;
  @override
  State<PreparedPreview> createState() => _PreparedPreviewState();
}

class _PreparedPreviewState extends State<PreparedPreview> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        prepare();
      }
    });
  }

  List<T> widgets<T extends Widget>() {
    final found = <T>[];
    void visit(final Element element) {
      if (element.widget is T) {
        found.add(element.widget as T);
      }
      element.visitChildren(visit);
    }

    (context as Element).visitChildren(visit);
    return found;
  }

  void prepare() {
    switch (widget.action) {
      case PreviewAction.reveal:
        widgets<InkWell>().first.onTap!();
      case PreviewAction.expand:
      case PreviewAction.deviceDialog:
        widgets<ListTile>().first.onTap!();
      case PreviewAction.invalidInput:
        widgets<TextField>().first.controller!.text = 'invalid name!';
      case PreviewAction.validKey:
      case PreviewAction.invalidKey:
        final form = widgets<SshKeyFormView>().first.sshKeyForm.form;
        form.control('key').value = widget.action == PreviewAction.validKey
            ? demoKey
            : 'invalid key';
        form.markAllAsTouched();
      case PreviewAction.chipDialog:
        widgets<ActionChip>().first.onPressed!();
      case PreviewAction.inplaceRestore:
        widgets<RadioSelectionCard>().last.onTap();
      case PreviewAction.deselectBackups:
        widgets<CheckboxListTile>().first.onChanged!(false);
      case PreviewAction.copyKey:
        widgets<FilledButton>().last.onPressed!();
    }
  }

  @override
  Widget build(final BuildContext context) => widget.child;
}
