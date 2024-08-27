/* Flutter Imports */
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/features/finance_report/presentation/pages/finance_report.dart';
import 'package:union/features/transaction/presentation/pages/transaction.dart';
import 'package:union/features/navigation/presentation/pages/navigation.dart';
import 'package:union/features/group/presentation/pages/group_detail.dart';
import 'package:union/features/profile/presentation/pages/profile.dart';
import 'package:union/features/splash/presentation/pages/splash.dart';
import 'package:union/features/auth/presentation/pages/register.dart';
import 'package:union/features/auth/presentation/pages/recovery.dart';
import 'package:union/features/group/presentation/pages/group.dart';
import 'package:union/features/auth/presentation/pages/login.dart';

const String splash = '/';
const String navigation = '/navigation';
// Auth
const String login = '/login';
const String register = '/register';
const String recovery = '/recovery';
// Profile
const String profile = '/profile';
const String editProfile = '/edit-profile';
const String changePassword = '/change-password';
// Group
const String group = '/group';
const String groupDetail = '/group-detail';
// Transaction
const String transaction = '/transaction';
const String createTransaction = '/create-transaction';
const String editTransaction = '/edit-transaction';
// Finance Report
const String financeReport = '/finance-report';

Route controller(RouteSettings settings) {
  switch (settings.name) {
    case splash:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case navigation:
      return MaterialPageRoute(builder: (_) => const NavigationPage());

    case login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case register:
      return MaterialPageRoute(builder: (_) => const RegisterPage());
    case recovery:
      return MaterialPageRoute(builder: (_) => const RecoveryPage());

    case profile:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case editProfile:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case changePassword:
      return MaterialPageRoute(builder: (_) => const ProfilePage());

    case group:
      return MaterialPageRoute(builder: (_) => const GroupPage());
    case groupDetail:
      final String groupId = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => GroupDetailPage(groupId: groupId));

    case transaction:
      return MaterialPageRoute(builder: (_) => const TransactionPage());
    case createTransaction:
      return MaterialPageRoute(builder: (_) => const TransactionPage());
    case editTransaction:
      return MaterialPageRoute(builder: (_) => const TransactionPage());

    case financeReport:
      return MaterialPageRoute(builder: (_) => const FinanceReportPage());

    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}
