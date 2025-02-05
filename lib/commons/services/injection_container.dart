import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_rating/data/datasource/auth_datasource.dart';
import 'package:teacher_rating/data/datasource/rating_datasource.dart';
import 'package:teacher_rating/providers/auth_provider.dart';
import 'package:teacher_rating/providers/rating_provider.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  final prefs = await SharedPreferences.getInstance();
  getIt
    ..registerLazySingleton<SharedPreferences>(() => prefs)
    ..registerLazySingleton<AuthProvider>(
      () => AuthProvider(authDataSource: getIt()),
    )
    ..registerLazySingleton<RatingProvider>(
      () => RatingProvider(remoteDatasource: getIt()),
    )
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDataSource(),
    )
    ..registerLazySingleton<RatingDatasource>(
      () => RatingDatasource(),
    );
}
