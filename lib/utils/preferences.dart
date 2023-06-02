import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();

  factory Preferences() {
    return _preferences;
  }

  Preferences._internal();

  SharedPreferences? _sharedPreferences;

  Future inIt() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  ///---------------Token---------------------

  setToken(String token) {
    _sharedPreferences!.setString("token", token);
  }

  getToken() {
    return _sharedPreferences!.getString("token") ?? "";
  }

  //=====================================================================
  setUid(int uid) {
    _sharedPreferences!.setInt("uid", uid);
  }

  getUid() {
    return _sharedPreferences!.getInt("uid") ?? "";
  }

  setNumber(String token) {
    _sharedPreferences!.setString("number", token);
  }

  getNumber() {
    return _sharedPreferences!.getString("number") ?? "";
  }

  ///---------------City Name---------------------

  setCityName(String cityName) {
    _sharedPreferences!.setString("cityName", cityName);
  }

  getCityName() {
    return _sharedPreferences!.getString("cityName") ?? "";
  }

  ///---------------City Id---------------------

  setCityId(String cityId) {
    _sharedPreferences!.setString("cityId", cityId);
  }
  setStateId(String stateId) {
    _sharedPreferences!.setString("stateId", stateId);
  }
  getStateId() {
    return _sharedPreferences!.getString("stateId");
  }

  getCityId() {
    return _sharedPreferences!.getString("cityId") ?? "";
  }

  ///---------------City Id---------------------

  setUserRegistered() {
    _sharedPreferences!.setBool("isRegistered", true);
  }

  getRegistered() {
    return _sharedPreferences!.getBool("isRegistered") ?? false;
  }

  //get name -------------------------------------------------------

  setName(String cityId) {
    _sharedPreferences!.setString("cityId", cityId);
  }

  getName() {
    return _sharedPreferences!.getString("cityId") ?? "";
  }


  clear() {
    return _sharedPreferences?.clear();
  }
}
