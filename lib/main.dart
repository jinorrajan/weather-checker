import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathe_checker/data/dataService/weather_data_service.dart';
import 'package:weathe_checker/presentaion/onboarding/onboarding_screen.dart';
import 'package:weathe_checker/presentaion/views/home/screen_home.dart';
import 'package:weathe_checker/presentaion/views/widgets/search.dart';
import 'package:weathe_checker/utlis/constants/colors/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboardingScren") ?? false;


   Get.put(WeatherService());
  runApp( MyApp(
    onBoarding: onboarding,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
   const MyApp({super.key, this.onBoarding = false});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'LexendMega',
        scaffoldBackgroundColor: Ccolors().backgroundColor,
        useMaterial3: true,
      ),
      
       home: onBoarding ? const HomeScreen() : const OnboardingScreen(),
    
      routes: {
        SearchScreen.routName: (ctx) => const SearchScreen(),
      },
    );
  }
}
