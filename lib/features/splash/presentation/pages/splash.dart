/* Flutter Imports */
import 'dart:async';
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union/core/themes/palette.dart';

/* Project Imports */
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/config/routes/router.dart' as routes;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(AuthIsLoggedInEvent());
      _authSubscription = authBloc.stream.listen((state) {
        if (state is AuthSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            routes.navigation,
            (route) => false,
          );
        } else if (state is AuthErrorState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            routes.login,
            (route) => false,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final String package = backgroundColor == Palette.background
        ? 'assets/icon/icon-light.png'
        : 'assets/icon/icon-dark.png';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(child: Image(image: AssetImage(package), height: 300)),
            const SizedBox(height: 20),
            Text('from', style: textTheme.bodySmall),
            Text(
              'RochaGabriell.dev',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
