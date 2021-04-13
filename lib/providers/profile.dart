// import 'package:flutter/foundation.dart';
// import 'package:thaki/globals/index.dart';
// import 'package:thaki/models/index.dart';
// import 'package:thaki/utilities/index.dart';
//
// enum TkProfileError {
//   loadCars,
//   addCar,
//   updateCar,
//   deleteCar,
//   loadCards,
//   addCard,
//   updateCard,
//   deleteCard
// }
//
// class TkProfile extends ChangeNotifier {
//   // Helpers
//   static TkAPIHelper _apis = new TkAPIHelper();
//
//   // Model variables
//
//   // Loading variables
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   // Error variables
//   Map<TkProfileError, String> _error = Map();
//   Map<TkProfileError, String> get error => _error;
//   void clearErrors() => _error.clear();
//
//   /// Get user cars, calls API and loads user model
//   Future<bool> loadCars(TkUser user) async {
//     // Start any loading indicators
//     _isLoading = true;
//     _error[TkProfileError.loadCars] = null;
//
//     Map result = await _apis.loadCars(user: user);
//     print(result[kStatusTag]);
//     if (result[kStatusTag] == kSuccessCode) {
//       // Load user data
//       user.updateModelFromJson(result[kDataTag]);
//     } else {
//       // an error happened
//       _error[TkProfileError.loadCars] =
//           result[kErrorMessageTag] ?? kUnknownError;
//     }
//
//     // Stop any listening loading indicators
//     _isLoading = false;
//     notifyListeners();
//
//     return (_error[TkProfileError.loadCars] == null);
//   }
//
//   /// Get user cars, calls API and loads user model
//   Future<bool> addCar(TkUser user, TkCar car) async {
//     // Start any loading indicators
//     _isLoading = true;
//     _error[TkProfileError.addCar] = null;
//
//     Map result = await _apis.addCar(user: user, car: car);
//     if (result[kStatusTag] == kSuccessCode) {
//       // Load user data
//       user.updateModelFromJson(result[kDataTag]);
//     } else {
//       // an error happened
//       _error[TkProfileError.addCar] = result[kErrorMessageTag] ?? kUnknownError;
//     }
//
//     // Stop any listening loading indicators
//     _isLoading = false;
//     notifyListeners();
//
//     return (_error[TkProfileError.addCar] == null);
//   }
// }
