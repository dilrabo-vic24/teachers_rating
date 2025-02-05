import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teacher_rating/data/datasource/auth_datasource.dart';

class AuthProvider extends ChangeNotifier {
  final AuthDataSource authDataSource;

  AuthProvider({required this.authDataSource});
  bool isVisible = false;
  bool isLoading = false;
  String message = "";

  //change password visibilty
  void toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

//register student
  Future<void> register(
      {required String name,
      required String phoneNumber,
      required String password}) async {
    isLoading = true;
    notifyListeners();
    final result = await authDataSource.register(name, phoneNumber, password);
    result.fold(
      (l) => message = l,
      (r) => message = r,
    );
    log(message);
    // log("message $message");
    isLoading = false;
    notifyListeners();
  }

//login student
  Future<void> login(
      {required String phoneNumber, required String password}) async {
    isLoading = true;
    notifyListeners();

    final result = await authDataSource.login(phoneNumber, password);
    result.fold(
      (l) => message = l,
      (r) => message = r,
    );
    isLoading = false;
    notifyListeners();
  }
}
