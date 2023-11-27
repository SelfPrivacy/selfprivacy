import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/providers/providers_cubit.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/ui/components/cards/outlined_card.dart';

class BrokenDomainOutlinedCard extends StatelessWidget {
  const BrokenDomainOutlinedCard({
    required this.domain,
    required this.dnsProvider,
    super.key,
  });

  final String domain;
  final DnsProvider dnsProvider;

  @override
  Widget build(final BuildContext context) => SizedBox(
        width: double.infinity,
        child: OutlinedCard(
          borderColor: Theme.of(context).colorScheme.error,
          borderWidth: 1,
          child: InkResponse(
            highlightShape: BoxShape.rectangle,
            onTap: () => context.read<SupportSystemCubit>().showArticle(
                  article: dnsProvider.howToRegistar,
                  context: context,
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        domain,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text('initializing.domain_critical_error'.tr()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
