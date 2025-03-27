import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_assessment/core/utils/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/app_theme.dart';
import 'config/router.dart';
import 'core/constants/app_constants.dart';
import 'features/github_accounts/presentation/blocs/github_account_bloc.dart';
import 'features/github_accounts/presentation/blocs/github_account_event.dart';
import 'features/github_accounts/data/services/github_api_service.dart';
import 'features/github_accounts/data/repositories/github_account_repository_impl.dart';
import 'core/network/dio_provider.dart';
import 'features/github_accounts/domain/usecases/search_accounts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app resources (dotenv, Hive, etc.)
  await AppInitializer.initialize();

  runApp(const MyApp());
}

/// A class responsible for initializing app resources such as dotenv and Hive.
class AppInitializer {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
      await Hive.initFlutter();
      await Hive.openBox(AppConstants.likedAccountsBox);
      await Hive.openBox(AppConstants.recentSearchesBox);
    } catch (e) {
      appLog('Initialization failed: $e');
      rethrow;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = GitHubAccountRepositoryImpl(
      GitHubApiService(DioProvider.createDio()),
    );

    return BlocProvider(
      create: (_) => GitHubAccountBloc(
        searchAccounts: SearchAccounts(repository),
      )..add(LoadLikedAccounts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub Accounts',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
