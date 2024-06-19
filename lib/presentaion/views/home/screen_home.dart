import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weathe_checker/data/localdata/locationSharedpreference.dart';
import 'package:weathe_checker/config/controllers/weather_controller.dart';
import 'package:weathe_checker/domain/models/future_weather_api_model.dart';
import 'package:weathe_checker/domain/models/location_model.dart';
import 'package:weathe_checker/presentaion/views/widgets/custom_app_bar.dart';
import 'package:weathe_checker/utlis/constants/colors/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'Loading...';

   final WeatherController weatherController = Get.put(WeatherController());

  Future<void> _loadLocationData() async {
    LocationModel? location = await LocationSharedPreference.loadLocationData();
    if (location != null) {
      weatherController.setlocation(location.latitude!, location.longitude!);
    } else {
      setState(() {
        address = 'No location data found.';
      });
    }
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadLocationData();
  }
  @override
  Widget build(BuildContext context) {
   
    double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(body: Obx(() {
      if (weatherController.loading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (weatherController.datamodel.value == null) {
          return Center(child: Text("No data available"));
        }
        final weatherData = weatherController.datamodel.value;
        final futureWeatherData = weatherController.futureDataModel.value.list ?? [];
       
        if(weatherData == null || futureWeatherData.isEmpty ){
          return Center(child: Text("No data Available"),);
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Custom AppBar used in body
                const Cappbar(),

                const SizedBox(
                  height: 30,
                ),

                Text(
                  ' ${weatherData.name},${weatherData.sys!.country} ',
                  style: TextStyle(
                      color: Ccolors().whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 21,
                ),

                Lottie.asset('assets/animation/cloudy sun.json',
                    height: 174, width: 225, repeat: false),

                const SizedBox(
                  height: 40,
                ),
                Text(
                  "${weatherData.weather?.first.description}",
                  style: TextStyle(
                      color: Ccolors().whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 113,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(16, 56, 56, 56),
                      ),
                      child:  WeatherCondition(
                        text: 'Wind Speed',
                        num: "${weatherData.wind!.speed}",
                      ),
                    ),
                    Container(
                      width: 113,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(16, 56, 56, 56),
                      ),
                      child:  WeatherCondition(
                        text: 'Temp',
                        num: "${weatherData.main!.temp}°C",
                      ),
                    ),
                    Container(
                      width: 113,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(16, 56, 56, 56),
                      ),
                      child:  WeatherCondition(
                        text: 'Humidity',
                        num: "${weatherData.main!.humidity}",
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                // past days
                Container(
                    height: screenHeigth * 0.25,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(16, 56, 56, 56),
                        borderRadius:  BorderRadius.only(
                          topRight: Radius.circular(38),
                          topLeft: Radius.circular(38),
                        )),
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 19, left: 19),
                          child: Text(
                            'Future 5 days/ 3 hours',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:futureWeatherData.length,
                          
                          itemBuilder: (BuildContext context, int index) {
                            final item = futureWeatherData[index];
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 85,
                                    left: 20,
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Ccolors().linerarGreadientTop,
                                            Ccolors().linerarGreadientBottom,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(21)),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 14,
                                        ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 12),
                                           child: Text(
                                            item.weather?.first.description?.value ?? '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,fontSize: 11),
                                                                                   ),
                                         ),

                                        const SizedBox(
                                          height: 13,
                                        ),
                                        //temp container
                                        Container(
                                          height: 25,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color:
                                                  Ccolors().backsecondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Center(
                                            child: Text(
                                              "Temp",
                                              style: TextStyle(
                                                  color: Colors.white,fontSize: 11),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 9,
                                        ),

                                         Center(
                                          child: Text(
                                            "${item.main?.temp}°C",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //Lottie animation
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 38, left: 30),
                                  child: Lottie.asset(
                                    'assets/animation/cloudy sun.json',
                                    height: 63,
                                    width: 84,
                                    repeat: false,
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      }
    }));
  }
}

class WeatherCondition extends StatelessWidget {
  final String text;
  final String num;
  const WeatherCondition({
    super.key,
    required this.text,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            text,
            style: TextStyle(color: Ccolors().whiteColor, fontSize: 13),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          num,
          style: TextStyle(
              color: Ccolors().whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
