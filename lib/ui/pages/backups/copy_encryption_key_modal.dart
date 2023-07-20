import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_jobs/server_jobs_cubit.dart';

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
  @override
  Widget build(final BuildContext context) {
    final String encryptionKey =
        context.watch<BackupsCubit>().state.backblazeBucket!.encryptionKey;
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                isKeyVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(
                  () {
                    isKeyVisible = !isKeyVisible;
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.copy_all_outlined),
              onPressed: () {
                getIt<NavigationService>()
                    .showSnackBar('basis.copied_to_clipboard'.tr());
                Clipboard.setData(
                  ClipboardData(
                    text: encryptionKey,
                  ),
                );
              },
            ),
          ],
        ),
        Flexible(
          child: isKeyVisible
              ? SelectableText(
                  encryptionKey,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                )
              : Text(
                  ''.padLeft(encryptionKey.length, '●'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
        ),
      ],
    );
  }
}
