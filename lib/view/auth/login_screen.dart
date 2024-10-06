import 'package:flutter/material.dart';
import 'package:get_your_fashion/utils/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../res/assets_images.dart';
import '../../res/components/circular_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final heights=MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Image.asset(AssetsImages.assetsLogoBg),
          ),
          const Text(
            "Account",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: heights / 90,
          ),
          const Text(
            "Log in or sign up to save collections, start\n customizing dresses, and be a "
                "part of\n GetYourFashion ",
          ),
          SizedBox(
            height: heights / 30,
          ),
          CircularButton(
            loading: authProvider.loading,
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: heights / 100,
                            ),
                            const Text(
                              "Login to continue",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: heights / 100,
                            ),
                            const Text(
                                "Enter your mobile number and we will send\n you a"
                                    "verification code"),
                            SizedBox(
                              height: heights / 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IntlPhoneField(
                                  controller: phoneNumber,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  initialCountryCode: 'IN',
                                ),
                              ),
                            ),
                            SizedBox(height: heights / 80),
                               CircularButton(
                                 onTap: (){
                                   if (phoneNumber.text.length == 10 && phoneNumber.text.isNotEmpty) {
                                    authProvider.userLogin(context, phoneNumber.text);
                                   }else{
                                     Utils.showErrorToastMassage('Please enter valid number');
                                   }
                                 },
                                label: "Send OTP",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            SizedBox(height: heights / 50),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            label: "Log in/Sign up",
          ),
        ],
      ),
    );
  }
}

