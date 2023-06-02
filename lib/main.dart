import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jym_app/screens/home_screen/creat_post_screen.dart';
import 'package:jym_app/screens/main_screen.dart';
import 'package:jym_app/screens/matrimony_screen/add_matrimony_profile_screen.dart';
import 'package:jym_app/screens/splash_screen.dart';
import 'package:jym_app/screens/verification_screen/mobile_number_screen.dart';
import 'package:jym_app/screens/verification_screen/otp_screen.dart';
import 'package:jym_app/screens/verification_screen/profile_screen.dart';
import 'package:jym_app/utils/preferences.dart';
import 'screens/drawer/add_family_members_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Preferences().inIt().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: CreatePostScreen(),
      // home: MainScreen(),
      // home: OtpScreen(),
      // home: AddFamilyMemberScreen(),
      // home: AddMatrimonyProfileScreen(),
      // home: ProfileScreen(),
    );
  }
}
