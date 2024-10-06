// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_your_fashion/provider/user_token_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/auth_model.dart';
import '../res/app_url.dart';
import '../utils/routes/routes_name.dart';

class AuthProvider with ChangeNotifier {

  bool _loading = false;
  bool get loading =>_loading;
  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }

  AuthModel? _loginResponse;

  AuthModel? get loginResponse => _loginResponse;

  Future userLogin(context,String phoneNumber) async {
    setLoading(true);
    final response = await http.post(
      Uri.parse(AppUrl.loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": phoneNumber}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if(responseData['error']=='200'){
        setLoading(false);
        _loginResponse = AuthModel.fromJson(responseData);
        Navigator.pushReplacementNamed(context,  RoutesName.otpScreen);
        return Fluttertoast.showToast(msg: responseData['msg']);
      }else{
        setLoading(false);
        Navigator.pushReplacementNamed(context,  RoutesName.otpScreen);
        _loginResponse = AuthModel.fromJson(responseData);
        return Fluttertoast.showToast(msg: responseData['msg']);
      }
    } else {
      setLoading(false);
      if (kDebugMode) {
        print('server error');
      }
    }
  }


  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future userRegister(context,String name,String phoneNumber,String gender,String age) async {
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(AppUrl.registerUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username":name,
        "mobile":phoneNumber,
        "gender":gender,
        "age":age
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setRegLoading(false);
      final userPref = Provider.of<UserTokenProvider>(context, listen: false);
      userPref.saveUser(AuthModel(userId: responseData['id'].toString()));
       Navigator.pushReplacementNamed(context,  RoutesName.bottomScreen);
      return Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }
}