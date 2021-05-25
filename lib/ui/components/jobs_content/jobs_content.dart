import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/logic/cubit/jobs/jobs_cubit.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_cards/brand_cards.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

class JobsContent extends StatelessWidget {
  const JobsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jobs = context.watch<JobsCubit>().state;
    return Column(
      children: [
        SizedBox(height: 15),
        Center(
          child: BrandText.h2(
            'jobs.title'.tr(),
          ),
        ),
        if (jobs.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: BrandText.body1('jobs.empty'.tr()),
          ),
        if (!jobs.isEmpty) ...[
          ...jobs.jobList
              .map(
                (j) => Row(
                  children: [
                    Expanded(
                      child: BrandCards.small(
                        child: Row(
                          children: [
                            BrandText.body1(j.title),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: BrandColors.red1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () =>
                          context.read<JobsCubit>().removeJob(j.id),
                      child: Text('Remove'),
                    ),
                  ],
                ),
              )
              .toList(),
          SizedBox(height: 20),
          BrandButton.rised(
            onPressed: () => context.read<JobsCubit>().applyAll(),
            text: 'jobs.start'.tr(),
          ),
        ],
      ],
    );
  }
}
