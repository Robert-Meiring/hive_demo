import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivetest/hive/database/hive_manager.dart';
import 'package:hivetest/hive/types/user_type.dart';
import 'package:hivetest/logic/user_events.dart';
import 'package:hivetest/logic/user_states.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserBloc() : super(InitialUserState()) {
    //On AddUserToHive, call the addUserToBox function from our Hive Manager class and pass through relevant variables
    on<AddUserToHive>((event, emit) async {
      HiveManager().addUserToBox(User(name: event.name, id: event.id, age: event.age));
      emit(UserAddedState());
    });
  }
}
