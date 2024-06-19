import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weathe_checker/data/localdata/locationSharedpreference.dart';
import 'package:weathe_checker/config/controllers/weather_controller.dart';
import 'package:weathe_checker/domain/models/location_model.dart';
import 'package:weathe_checker/presentaion/views/home/screen_home.dart';
import 'package:weathe_checker/presentaion/views/widgets/search.dart';
import 'package:weathe_checker/utlis/constants/colors/colors.dart';
import 'package:weathe_checker/utlis/resgisterService.dart';

void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();
  await regester();
  runApp( 
   const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   // WeatherController wcontroller = Get.put(WeatherController(),tag: 'hai',permanent: true);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'LexendMega',
        scaffoldBackgroundColor: Ccolors().backgroundColor,
        useMaterial3: true,
      ),
      home: HomeScreen(),
      routes: {
        SearchScreen.routName: (ctx) => const SearchScreen(),
      },
    );
  }
}
