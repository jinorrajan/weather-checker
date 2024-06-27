import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weathe_checker/data/localdata/locationSharedpreference.dart';
import 'package:weathe_checker/domain/models/location_model.dart';

class SearchScreen extends StatefulWidget {
  static const routName = 'search-screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  
  String address = '';
  String coordinates = '';
  String errorMessage= '';


  Future<void> converAdresstoLatLng() async {
    try {

      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final Location location = locations.first;
        final lat = location.latitude.toString();
        final lon = location.longitude.toString();

        // save the location data in sharedPreference
        LocationModel locationModel = LocationModel(latitude: lat, longitude: lon);
        await LocationSharedPreference.saveLocationData(locationModel);
        

        Get.back();
       
        setState(() {
          
          print('$locationModel');
          print('$lat');
          print('$lon');
          // coordinates = 'Latitude: ${lat},Longitude:${lon}';
        });
      } else {
        setState(() {
          errorMessage = "no Coordinate found for the address";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
      });
    }

    //  Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Builder(builder: (BuildContext ctx) {
              return IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:const Icon(
                  Icons.arrow_back_ios,
                  color:  Color.fromARGB(221, 176, 176, 176),
                ),
              );
            }),

//custom searchbar
            title: SizedBox(
              height: 40,
              width: screenwidth * 0.73,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Please Enter Your Location 📌";
                    }else{
                      return null;
                    }
                  },
                  style: const TextStyle(
                      color:  Color.fromARGB(221, 176, 176, 176)),
                  decoration: InputDecoration(
                      hintText: "Enter Location",
                      hintStyle: const TextStyle(
                        color:  Color.fromARGB(221, 176, 176, 176),
                        letterSpacing: 0.01,
                        height: 0.87,
                      ),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color:  Color.fromARGB(221, 176, 176, 176))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color:
                                   Color.fromARGB(221, 176, 176, 176)))),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
              ),
            )),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenwidth * 0.40, top: screenheight * 0.03),
              child: ElevatedButton(
                  onPressed: converAdresstoLatLng, child: Text("Enter")),
            ),
          ],
        ),
      ),
    );
  }
}
