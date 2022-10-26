import 'package:equatable/equatable.dart';

//The events abstract class is used as an efficient way to send data and instructions to our BLoC

abstract class UserEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserToHive extends UserEvents {
  final String name;
  final String id;
  final int age;

  AddUserToHive({required this.name, required this.id, required this.age});
}
