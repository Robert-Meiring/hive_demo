import 'package:equatable/equatable.dart';

//Our States abstract class is used by our BLoC to communicate back to our widgets.

abstract class UserStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialUserState extends UserStates {}

class UserAddedState extends UserStates {}
