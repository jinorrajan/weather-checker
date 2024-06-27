import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weathe_checker/data/localdata/locationSharedpreference.dart';
import 'package:weathe_checker/config/controllers/weather_controller.dart';
import 'package:weathe_checker/domain/models/future_weather_api_model.dart';
import 'package:weathe_checker/domain/models/location_model.dart';
import 'package:weathe_checker/presentaion/views/widgets/custom_app_bar.dart';
import 'package:weathe_checker/presentaion/views/widgets/weather_condition.dart';
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

    String getWeatherAnimation(String? description) {
    switch (description) {
      case 'clear sky':
        return 'assets/animation/cloudy sun.json';
      case 'few clouds':
      return 'assets/animation/Clouds.json';
      case 'scattered clouds':
      return 'assets/animation/Clouds.json';
      case 'broken clouds':
        return 'assets/animation/Clouds.json';
      case 'shower rain':
      return 'assets/animation/shower rain.json';
      case 'light rain':
      return 'assets/animation/shower rain.json';
      case 'rain':
              return 'assets/animation/rain.json';
      case 'thunderstorm':
              return 'assets/animation/thunder.json';
      case 'snow':
              return 'assets/animation/snow.json';
      case 'mist':
            return 'assets/animation/mist.json';
      case 'overcast clouds':
              return 'assets/animation/Clouds.json';
      default:
           return 'assets/animation/cloudy sun.json';
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(body: Obx(() {
      if (weatherController.loading.value) {
        print(weatherController.loading.value);
        return const Center(
          child: CircularProgressIndicator(
            
          ),
          
        );
      } else {
        final weatherData = weatherController.datamodel.value;
        final futureWeatherData =
            weatherController.futureDataModel.value.list ?? [];

        if (futureWeatherData.isEmpty) {
          const CircularProgressIndicator();
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Custom AppBar used in body
                const Cappbar(),

                const SizedBox(
                  height: 28,
                ),

                Text(
                  ' ${weatherData.name},${weatherData.sys!.country} ',
                  style: TextStyle(
                      color: Ccolors().whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 5
                ),

                Lottie.asset(getWeatherAnimation(weatherData.weather?.first.description),
                    height: 174, width: 225, repeat: true),

                const SizedBox(
                  height: 30,
                ),
                Text(
                  "${weatherData.weather?.first.description}",
                  style: TextStyle(
                      color: Ccolors().whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 113,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(16, 56, 56, 56),
                      ),
                      child: WeatherCondition(
                        text: 'Wind Speed',
                        num: "${weatherData.wind!.speed}",
                      ),
                    ),
                    Container(
                      width: 113,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(16, 56, 56, 56),
                      ),
                      child: WeatherCondition(
                        text: 'Temp',
                        num: "${weatherData.main!.temp}°C",
                      ),
                    ),
                    Container(
                      width: 113,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(16, 56, 56, 56),
                      ),
                      child: WeatherCondition(
                        text: 'Humidity',
                        num: "${weatherData.main!.humidity}",
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 38,
                ),

                // past days
                Container(
                    height: screenHeigth * 0.35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(16, 56, 56, 56),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(38),
                          topLeft: Radius.circular(38),
                        )),
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 19, left: 19),
                          child: Text(
                            'Future 5 days/ 3 hours',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                        physics: PageScrollPhysics(),
                          itemCount: futureWeatherData.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = futureWeatherData[index];
                            String formattedDate = item.formatDate(item.dtTxt!);
                            String formattedTime = item.formatTime(item.dtTxt!);

                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 85,
                                        left: 20,
                                      ),
                                      child: Container(
                                        height: screenHeigth * 0.15,
                                        width: 113,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Ccolors().linerarGreadientTop,
                                                Ccolors()
                                                    .linerarGreadientBottom,
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(21)),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 13,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 13,top: 10),
                                              child: Container(
                                                height: screenHeigth * 0.040,
                                                width: screenWidth * 0.25,
                                                child: Text(
                                                  item.weather?.first
                                                          .description?.value ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 1,
                                            ),
                                            //temp container
                                            Container(
                                              height: 25,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                  color: Ccolors()
                                                      .backsecondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Center(
                                                child: Text(
                                                  "Temp",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 9,
                                            ),

                                            Center(
                                              child: Text(
                                                "${item.main?.temp}°C",
                                                style: const TextStyle(
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
                                      padding: const EdgeInsets.only(
                                          top: 45, left: 30),
                                      child: Lottie.asset(
                                        getWeatherAnimation( item.weather?.first
                                                          .description?.value ??
                                                      ''),
                                        height: 70,
                                        width: 90,
                                        repeat: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeigth * 0.02,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: screenWidth * 0.05),
                                      child: Container(
                                        height: screenHeigth * 0.03,
                                        width: screenWidth * 0.25,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 2),
                                          child: Text(
                                            formattedDate,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),

                                     Padding(
                                       padding: const EdgeInsets.only(left: 13),
                                       child: Container(
                                           height: screenHeigth * 0.03,
                                            width: screenWidth * 0.2,
                                             decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Ccolors().linerarGreadientTop,
                                            Ccolors().linerarGreadientBottom,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(21)),
                                        child: Center(child: Text(formattedTime,style: const TextStyle(color: Colors.white,fontSize: 12),)),
                                        ),
                                     )
                                  ],
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
