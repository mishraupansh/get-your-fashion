import 'package:flutter/material.dart';
import 'package:get_your_fashion/res/components/circular_button.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String selectedGender = 'Select Gender';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loginRes = Provider.of<AuthProvider>(context).loginResponse;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage("assets/logo_bg.png"),
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(9),
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: loginRes!=null?loginRes.otp:''),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Enter Your Mobile Number",
                    hintText: "Enter Your Mobile Number",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your mobile number";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Mobile number should contain only numbers";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(9),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Enter Your Name",
                    hintText: "Enter Your Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: GestureDetector(
                  onTap: () {
                    _showGenderDialog(context);
                  },
                  child: Container(
                    width: 360,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Text(
                          selectedGender.isEmpty
                              ? 'Select a gender'
                              : selectedGender,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Age",
                    hintText: "Age",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your age";
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 12 || age > 100) {
                      return "Please enter a valid age (12-100)";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 17),
              CircularButton(
                label: "Next",
                fontWeight: FontWeight.bold,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    authProvider.userRegister(context, nameController.text,
                        loginRes!.otp.toString(), selectedGender, ageController.text);
                    // register(nameController.text, ageController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                onTap: () {
                  setState(() {
                    selectedGender = 'Male';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Female'),
                onTap: () {
                  setState(() {
                    selectedGender = 'Female';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Other'),
                onTap: () {
                  setState(() {
                    selectedGender = 'Other';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
