/* Flutter Imports */
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/features/finance_report/presentation/bloc/finance_report_bloc.dart';
import 'package:union/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/themes/bloc/theme_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:union/core/utils/injections.dart';
import 'package:union/core/themes/theme.dart';
import 'config/routes/router.dart' as routes;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserCubit>()),
        BlocProvider(create: (context) => getIt<ThemeBloc>()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<GroupBloc>()),
        BlocProvider(create: (context) => getIt<TransactionBloc>()),
        BlocProvider(create: (context) => getIt<FinanceReportBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Internationalization
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          // App
          title: 'Union',
          theme: CustomTheme.light,
          themeMode: state,
          darkTheme: CustomTheme.dark,
          onGenerateRoute: routes.controller,
          initialRoute: routes.splash,
        );
      },
    );
  }
}
