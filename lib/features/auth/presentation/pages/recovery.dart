/* Flutter Imports */
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/features/auth/presentation/widgets/form/recovery_form.dart';
// import 'package:union/features/auth/presentation/widgets/redirect_link.dart';
import 'package:union/features/auth/presentation/widgets/auth_title.dart';
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:union/config/routes/router.dart' as routes;
import 'package:union/core/utils/show_dialog.dart';
import 'package:union/core/enums/alert_type.dart';
import 'package:union/core/themes/palette.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryState();
}

class _RecoveryState extends State<RecoveryPage> {
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
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Palette.primary),
                ),
              );
            }
            return const Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AuthTitle(
                      title: 'Recuperar senha',
                      subtitle:
                          'Insira seu endereço de e-mail e enviaremos um link para redefinir sua senha',
                      visibleLogo: false,
                    ),
                    SizedBox(height: 24),
                    RecoveryForm(),
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
