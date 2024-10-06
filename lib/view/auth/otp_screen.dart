import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_your_fashion/models/auth_model.dart';
import 'package:get_your_fashion/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/user_token_provider.dart';
import '../../res/components/circular_button.dart';
import '../../res/components/custom_text_button.dart';
import '../../res/components/otp_field_widget.dart';
import '../../utils/routes/routes_name.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isButtonDisabled = true;
  int countdown = 60;
  late Timer countdownTimer;

  void startCountdown() {
    setState(() {
      isButtonDisabled = true;
      countdown = 60;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        setState(() {
          isButtonDisabled = false;
        });
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }
  List<TextEditingController> otpControllers = List.generate(4,
        (index) => TextEditingController(),
  );
  @override
  Widget build(BuildContext context) {
   final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
   final loginRes = Provider.of<AuthProvider>(context).loginResponse;
   final userPref = Provider.of<UserTokenProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: loginRes!=null?Stack(
          children: [
            Container(
              height: heights,
              width: widths,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 150),
                    child: Image.asset("assets/logo_bg.png"),
                  ),

                  const Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height:heights/70,),
                  const Text(
                    "Log in or sign up to save collections, starts\ncustomizing dresses and be a "
                        "part of the\nGetYourFashion ",
                  ),
                  const SizedBox(height: 20,),
                  const CircularButton(
                    label: "Log in / Sign up",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: widths,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Text(
                        "Login to continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(height:heights/80),
                    const Text("We just sent you a verification code on"),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Text("+91${loginRes.userId}"),
                            const Icon(Icons.edit),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:heights/80),
                    OtpFieldWidget(
                      pinLength: 4,
                      controllers: otpControllers,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Didn't receive code?"),
                        isButtonDisabled
                            ? const ConstantTextButton(
                          label: "Request again",
                          labelColor: Colors.grey,
                        )
                            : ConstantTextButton(
                          label: "Request again",
                          onTap: () {
                            startCountdown();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height:heights/100),
                    Text(
                      "00:${countdown.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height:heights/80),
                    CircularButton(
                      label: "Verify",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      onTap: () async {
                      if(loginRes.otp==otpControllers.map((e) => e.text).join() && loginRes.status=="1"){
                        userPref.saveUser(AuthModel(userId: loginRes.userId.toString()));
                        Navigator.pushNamed(context, RoutesName.bottomScreen);
                      }else if(loginRes.otp==otpControllers.map((e) => e.text).join() && loginRes.status=="0"){
                        Navigator.pushNamed(context, RoutesName.bottomScreen);
                      }else{
                        Utils.showErrorToastMassage("Please Enter a valid Otp");
                      }
                      },
                    ),
                    SizedBox(height:heights/50),
                  ],
                ),
              ),
            ),
          ],
        ):const Center(child: CircularProgressIndicator(color: Colors.grey,),),
      ),
    );
  }
}
