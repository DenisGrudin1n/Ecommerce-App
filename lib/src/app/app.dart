import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/theme.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: 'Ecommerce App',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: appRouter.config(),
    );
  }
}
