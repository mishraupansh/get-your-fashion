 // ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get_your_fashion/models/auth_model.dart';
import '../../utils/routes/routes_name.dart';
import '../user_token_provider.dart';

class SplashServices {
  Future<AuthModel> getUserData() => UserTokenProvider().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.userId.toString());
        print('valueId');
      }
      if (value.userId.toString() == 'null' || value.userId.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.loginScreen);
      } else {
        await Future.delayed(const Duration(seconds: 3));
         Navigator.pushNamed(context, RoutesName.bottomScreen);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}