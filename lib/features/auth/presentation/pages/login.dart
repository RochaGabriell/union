/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/features/auth/presentation/widgets/form/login_form.dart';
import 'package:union/features/auth/presentation/widgets/redirect_link.dart';
import 'package:union/features/auth/presentation/widgets/auth_title.dart';
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/config/routes/router.dart' as routes;
import 'package:union/core/utils/show_dialog.dart';
import 'package:union/core/enums/alert_type.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              showMessageDialog(
                context,
                title: 'Ops...',
                message: state.message,
                type: AlertType.error,
                onConfirm: () {},
              );
            } else if (state is AuthSuccessState) {
              showMessageDialog(
                context,
                title: 'Sucesso!',
                message: 'Login efetuado com sucesso!',
                type: AlertType.success,
                onRedirect: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    routes.navigation,
                    (route) => false,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthTitle(),
                    const LoginForm(),
                    const SizedBox(height: 80),
                    RedirectLink(
                      text: 'Não tem uma conta?',
                      link: 'Registre-se',
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          routes.register,
                          (route) => false,
                        );
                      },
                    ),
                    // const DividerCustom(),
                    // RedirectLink(
                    //   text: 'Esqueceu sua senha?',
                    //   link: 'Recupere',
                    //   onTap: () {
                    //     Navigator.pushNamed(context, routes.recovery);
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
