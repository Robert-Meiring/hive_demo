import 'package:hive/hive.dart';
import 'package:hivetest/hive/types/user_type.dart';

//Hive Manager Class

class HiveManager {
  //Function to init/open our box
  Future<void> initBoxes() async {
    await Hive.openBox('userbox');
  }

  //Function to add a user entity to our box
  Future<void> addUserToBox(User user) async {
    final Box _userBox = Hive.box('userbox');
    await _userBox.put('user', user);
  }

  //Function to get the current user in the box and return the User entity
  User? getCurrentUser() {
    final Box _userBox = Hive.box('userbox');
    final User? userInstance = _userBox.get('user');
    return userInstance;
  }
}
