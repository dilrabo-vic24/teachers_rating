import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:teacher_rating/commons/go_routers/go_router.dart';
import 'package:teacher_rating/commons/services/injection_container.dart';
import 'package:teacher_rating/providers/auth_provider.dart';
import 'package:teacher_rating/providers/rating_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(authDataSource: getIt()),
        ),
        ChangeNotifierProvider(
            create: (context) => RatingProvider(remoteDatasource: getIt())),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          child: MaterialApp.router(
            routerConfig: router,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurpleAccent,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: ThemeMode.system,
          )),
    );
  }
}
