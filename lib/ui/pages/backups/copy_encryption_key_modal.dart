import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_bloc.dart';
import 'package:selfprivacy/ui/components/info_box/info_box.dart';
import 'package:selfprivacy/utils/platform_adapter.dart';

class CopyEncryptionKeyModal extends StatefulWidget {
  const CopyEncryptionKeyModal({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  State<CopyEncryptionKeyModal> createState() => _CopyEncryptionKeyModalState();
}

class _CopyEncryptionKeyModalState extends State<CopyEncryptionKeyModal> {
  bool isKeyVisible = false;
  bool copiedToClipboard = false;
  Timer? copyToClipboardTimer;

  @override
  void dispose() {
    copyToClipboardTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final String? encryptionKey =
        context.watch<BackupsCubit>().state.backblazeBucket?.encryptionKey;
    if (encryptionKey == null) {
      return ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Text(
            'backup.backups_encryption_key'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          InfoBox(
            text: 'backup.backups_encryption_key_not_found'.tr(),
            isWarning: true,
          ),
        ],
      );
    }
    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'backup.backups_encryption_key'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'backup.backups_encryption_key_description'.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              SelectableText(
                encryptionKey,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Positioned.fill(
                child: InkWell(
                  onTap: () {
                    setState(
                      () {
                        isKeyVisible = !isKeyVisible;
                      },
                    );
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isKeyVisible ? 0 : 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.visibility_outlined),
                          const SizedBox(width: 8),
                          Text(
                            'backup.backups_encryption_key_show'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () {
            setState(
              () {
                copiedToClipboard = true;
              },
            );
            setState(() {
              copyToClipboardTimer?.cancel();
              copyToClipboardTimer = Timer(
                const Duration(seconds: 5),
                () {
                  setState(() {
                    copiedToClipboard = false;
                  });
                },
              );
            });
            PlatformAdapter.setClipboard(encryptionKey);
          },
          icon: const Icon(Icons.copy_all_outlined),
          label: Text(
            copiedToClipboard
                ? 'basis.copied_to_clipboard'.tr()
                : 'backup.backups_encryption_key_copy'.tr(),
          ),
        ),
      ],
    );
  }
}
