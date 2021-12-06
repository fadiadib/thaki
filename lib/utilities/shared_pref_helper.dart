import 'package:shared_preferences/shared_preferences.dart';

class TkSharedPrefHelper {
  /// Stores a data using a tag into the shared preferences
  /// Returns success or failure
  Future<bool> store({required String tag, required String data}) async {
    // Get shared preference object
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store data in shared preferences
    return await prefs.setString(tag, data);
  }

  /// Remove a tag from the shared preferences
  /// Returns success or failure
  Future<bool> delete({required String tag}) async {
    // Get shared preference object
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove tag from shared preferences
    return await prefs.remove(tag);
  }

  /// Gets a tag from the shared preferences
  /// Returns success or failure
  Future<String?> get({required String tag}) async {
    // Get shared preference object
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get data from shared preferences using tag
    return prefs.getString(tag);
  }
}
