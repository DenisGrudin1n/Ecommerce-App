import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/enter_phone_page.dart';
import 'package:ecommerce_app/src/features/login/presentation/pages/get_started_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: GetStartedRoute.page),
        AutoRoute(page: EnterPhoneRoute.page, initial: true),
      ];
}
