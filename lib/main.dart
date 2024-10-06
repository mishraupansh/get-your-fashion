import 'package:flutter/material.dart';
import 'package:get_your_fashion/provider/auth_provider.dart';
import 'package:get_your_fashion/provider/user_token_provider.dart';
import 'package:get_your_fashion/utils/routes/routes.dart';
import 'package:get_your_fashion/view/home/category_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserTokenProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '${Routes.splash}', // Use '${Routes.splash}' to access the route string properly
        routes: routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white), // Adjust as needed
          dividerColor: Colors.transparent,
          // useMaterial3: true, // Not sure if you intend to enable this or not
        ),
        home: CategoryScreen(),
      ),
    );
  }
}
