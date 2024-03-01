import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/logic/cubit/support_system/support_system_cubit.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/ui/components/cards/filled_card.dart';

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
        child: FilledCard(
          error: true,
          child: InkResponse(
            highlightShape: BoxShape.rectangle,
            onTap: () => context.read<SupportSystemCubit>().showArticle(
                  article: dnsProvider.howToRegistar,
                  context: context,
                ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                    size: 24.0,
                  ),
                  const SizedBox(width: 12.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          domain,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text('initializing.domain_critical_error'.tr()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
