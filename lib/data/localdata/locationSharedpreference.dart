
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathe_checker/domain/models/location_model.dart';

class LocationSharedPreference{


  static Future<void> saveLocationData(LocationModel location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lat', location.latitude!);
    prefs.setString('lon', location.longitude!);
    
  }

 static Future<LocationModel?> loadLocationData() async{
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getString('lat');
    final lon = prefs.getString('lon');

    if(lat != null && lon != null){
       return LocationModel(latitude:lat, longitude: lon);
    }else{
      return null;
    }
  }

  Future<void> saveAddress(Address address) async{
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('address', address.place);
  }
  Future<Address?> loadAddress() async{
    final prefs = await SharedPreferences.getInstance();

    final place = prefs.getString('address');

    if(place != null){
      return Address(place);
    }else{
      return null;
    }
  }
}
