part of 'users.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(final BuildContext context) => BrandBottomSheet(
        child: BlocProvider(
          create: (final BuildContext context) => UserFormCubit(
            jobsCubit: context.read<JobsCubit>(),
            fieldFactory: FieldCubitFactory(context),
            initialUser: user,
          ),
          child: Builder(
            builder: (final BuildContext context) {
              final FormCubitState formCubitState =
                  context.watch<UserFormCubit>().state;

              return BlocListener<UserFormCubit, FormCubitState>(
                listener:
                    (final BuildContext context, final FormCubitState state) {
                  if (state.isSubmitted) {
                    Navigator.pop(context);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BrandHeader(
                      title: 'users.reset_password'.tr(),
                    ),
                    const SizedBox(width: 14),
                    Padding(
                      padding: paddingH15V0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CubitFormTextField(
                            formFieldCubit:
                                context.read<UserFormCubit>().password,
                            decoration: InputDecoration(
                              alignLabelWithHint: false,
                              labelText: 'basis.password'.tr(),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                  icon: Icon(
                                    BrandIcons.refresh,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  onPressed: context
                                      .read<UserFormCubit>()
                                      .genNewPassword,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          BrandButton.rised(
                            onPressed: formCubitState.isSubmitting
                                ? null
                                : () =>
                                    context.read<UserFormCubit>().trySubmit(),
                            text: 'basis.apply'.tr(),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
