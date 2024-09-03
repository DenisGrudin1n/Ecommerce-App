import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/theme.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:ecommerce_app/src/repositories/auth/firebase_auth_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/firebase_storage_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final AppRouter appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuthRepository>(
          create: (_) => FirebaseAuthRepository(FirebaseAuth.instance),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => context.read<FirebaseAuthRepository>(),
        ),
        RepositoryProvider<FirebaseStorageRepository>(
          create: (_) => FirebaseStorageRepository(FirebaseStorage.instance),
        ),
        RepositoryProvider<StorageRepository>(
          create: (context) => context.read<FirebaseStorageRepository>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Ecommerce App',
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
