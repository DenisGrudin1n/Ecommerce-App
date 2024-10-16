import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/l10n/l10n.dart';
import 'package:ecommerce_app/core/theme/theme.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/cart/presentation/pages/shipping_address_editing_page/bloc/shipping_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/filter_page/bloc/filter_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_bloc.dart';
import 'package:ecommerce_app/src/features/home/presentation/pages/items_page/bloc/items_event.dart';
import 'package:ecommerce_app/src/repositories/auth/auth_repository.dart';
import 'package:ecommerce_app/src/repositories/auth/firebase_auth_repository.dart';
import 'package:ecommerce_app/src/repositories/database/database_repository.dart';
import 'package:ecommerce_app/src/repositories/database/firestore_database_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/firebase_storage_repository.dart';
import 'package:ecommerce_app/src/repositories/storage/storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final AppRouter appRouter = AppRouter();
final user = FirebaseAuth.instance.currentUser;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return buildProviders(
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

  Widget buildProviders({required Widget child}) {
    return user != null
        ? MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                create: (context) =>
                    FirebaseAuthRepository(FirebaseAuth.instance),
              ),
              RepositoryProvider<StorageRepository>(
                create: (context) =>
                    FirebaseStorageRepository(FirebaseStorage.instance),
              ),
              RepositoryProvider<DatabaseRepository>(
                create: (context) =>
                    FirestoreDatabaseRepository(FirebaseFirestore.instance),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => FilterBloc(
                    firestoreRepository: context.read<DatabaseRepository>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => ShippingBloc(),
                ),
                BlocProvider(
                  create: (context) => ItemsBloc(
                    storageRepository: context.read<StorageRepository>(),
                    firestoreRepository: context.read<DatabaseRepository>(),
                  )
                    ..add(const LoadItemsEvent(''))
                    ..add(LoadItemsCategoriesEvent()),
                ),
              ],
              child: child,
            ),
          )
        : MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                create: (context) =>
                    FirebaseAuthRepository(FirebaseAuth.instance),
              ),
            ],
            child: child,
          );
  }
}
