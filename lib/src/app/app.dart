import 'package:ecommerce_app/core/localization/localization.dart';
import 'package:ecommerce_app/core/theme/theme.dart';
import 'package:ecommerce_app/src/app/router/router.dart';
import 'package:ecommerce_app/src/features/login/bloc/enter_phone_page/bloc/phone_input_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final AppRouter appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PhoneInputBloc(),
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
