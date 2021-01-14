part of 'users.dart';

class _NewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersCubit = context.watch<UsersCubit>();

    return BrandModalSheet(
      child: BlocProvider(
        create: (context) => UserFormCubit(usersCubit: usersCubit),
        child: Builder(builder: (context) {
          var formCubit = context.watch<UserFormCubit>();

          return BlocListener<UserFormCubit, FormCubitState>(
            listener: (context, state) {
              if (state.isSubmitted) {
                Navigator.pop(context);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandHeader(title: 'Новый пользователь'),
                SizedBox(width: 14),
                Padding(
                  padding: brandPagePadding2,
                  child: Column(
                    children: [
                      CubitFormTextField(
                        formFieldCubit: formCubit.login,
                        decoration: InputDecoration(
                          labelText: 'Логин',
                          suffixText: '@example',
                        ),
                      ),
                      SizedBox(height: 20),
                      CubitFormTextField(
                        formFieldCubit: formCubit.password,
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          labelText: 'Пароль',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: IconButton(
                              icon: Icon(
                                BrandIcons.refresh,
                                color: BrandColors.blue,
                              ),
                              onPressed: formCubit.genNewPassword,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      BrandButton.rised(
                        onPressed: formCubit.state.isSubmitting
                            ? null
                            : () {
                                formCubit.trySubmit();
                              },
                        title: 'Создать',
                      ),
                      SizedBox(height: 40),
                      Text(
                          'Новый пользователь автоматически получит доступ ко всем сервисам. Ещё какое-то описание.'),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
