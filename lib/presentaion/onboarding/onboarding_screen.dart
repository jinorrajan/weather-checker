import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathe_checker/data/localdata/locationSharedpreference.dart';
import 'package:weathe_checker/domain/models/location_model.dart';
import 'package:weathe_checker/presentaion/views/home/screen_home.dart';
import 'package:weathe_checker/utlis/constants/colors/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentpage = 0;
  late String lat;
  late String lon;
  late String text;
  late Position curentPos;

//Getting Current Location
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "please enable");
    }

    //Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }
    if(permission == LocationPermission.whileInUse){
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final latt = position.latitude.toString();
      final lonn = position.longitude.toString();


      //Save  location 
      LocationModel locationModel =
          LocationModel(latitude: latt, longitude: lonn);
      await LocationSharedPreference.saveLocationData(locationModel);
    }

    try {
      getdata();
      Get.off(const HomeScreen());
    } catch (e) {
      print("Error getting location: $e");
      Fluttertoast.showToast(msg: "Error getting location: $e");
    }

    return Future.error(e);
  }

  getdata()async{
     Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final latt = position.latitude.toString();
      final lonn = position.longitude.toString();


      //Save  location 
      LocationModel locationModel =
          LocationModel(latitude: latt, longitude: lonn);
      await LocationSharedPreference.saveLocationData(locationModel);
  }

  @override
  void initState() {
    getdata();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentpage = _pageController.page?.round() ?? 0;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const  SizedBox(
            height: 200,
          ),
          Expanded(
            child: PageView.builder(
              itemCount: onboard.length,
              controller: _pageController,
              itemBuilder: (context, index) => OnboardScreen(
                  image: onboard[index].image,
                  text1: onboard[index].text1,
                  text2: onboard[index].text2,
                  text3: onboard[index].text3),
            ),
          ),
          // const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50, bottom: 30),
                child: InkWell(
                  splashColor: Ccolors().backgroundColor,
                  onTap: () async {
                    final pres = await SharedPreferences.getInstance();

                    if (_currentpage < onboard.length - 1) {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    } else {
                      pres.setBool("onboardingScren", true);

                      getCurrentLocation();
                      
                    }
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(Icons.arrow_right_alt),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

//onboard data creation
class OnboardData {
  final String image, text1, text2, text3;

  OnboardData({
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
  });
}

final List<OnboardData> onboard = [
  OnboardData(
      image: 'assets/images/1.png',
      text1: 'Wherever you go,',
      text2: 'no matter what the weather,',
      text3: 'always bring your own sunshine')
];

class OnboardScreen extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;
  final String text3;
  OnboardScreen({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(),
          child: SizedBox(
            height: 200,
            width: 200,
            child: CircleAvatar(backgroundImage: AssetImage(image)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
            child: OnboardTextWudget(
          text: text1,
        )),
        Center(
            child: OnboardTextWudget(
          text: text2,
        )),
        Center(
            child: OnboardTextWudget(
          text: text3,
        )),
      ],
    );
  }
}

class OnboardTextWudget extends StatelessWidget {
  final String text;
  const OnboardTextWudget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}
