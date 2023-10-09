import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:note_app/modules/home/view/home_view.dart';
import 'package:note_app/modules/note/view/note_detail_view.dart';
import 'package:note_app/modules/sign_in/view/sign_in_view.dart';
import 'package:note_app/modules/sign_up/view/sign_up_view.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route,Page')
class AppRouter extends _$AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomePageRoute.page),
        AutoRoute(page: SignInPageRoute.page, initial: true),
        AutoRoute(page: SignUpPageRoute.page),
        AutoRoute(page: NoteDetailPageRoute.page),
      ];
}
