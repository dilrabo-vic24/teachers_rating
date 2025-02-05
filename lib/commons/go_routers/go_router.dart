import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_rating/commons/constants/prefs_keys.dart';
import 'package:teacher_rating/commons/services/injection_container.dart';
import 'package:teacher_rating/presentations/screens/login_screen.dart';
import 'package:teacher_rating/presentations/screens/register_screen.dart';
import 'package:teacher_rating/presentations/screens/comments_screen.dart';
import 'package:teacher_rating/presentations/screens/teachers_screen.dart';
import 'package:teacher_rating/presentations/screens/top_teachers_screen.dart';

final GoRouter router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    builder: (context, state) =>
        getIt<SharedPreferences>().getString(PrefsKeys.idKey) != null
            ? TeachersScreen()
            : LoginScreen(),
  ),
  GoRoute(
    path: LoginScreen.path,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: RegisterScreen.path,
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    path: TeachersScreen.path,
    builder: (context, state) => TeachersScreen(),
  ),
  GoRoute(
    path: CommentsScreen.path,
    builder: (context, state) {
      final teacherID = state.extra as String;
      return CommentsScreen(teacherID: teacherID);
    },
  ),
  GoRoute(
    path: TopTeachersScreen.path,
    builder: (context, state) => TopTeachersScreen(),
  ),
]);
