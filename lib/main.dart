import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivetest/hive/database/hive_manager.dart';
import 'package:hivetest/logic/user_bloc.dart';
import 'package:hivetest/logic/user_events.dart';
import 'package:hivetest/logic/user_states.dart';
import 'package:hivetest/registerfactory/register_factory.dart';

import 'hive/types/user_type.dart';

Future<void> main() async {
  RegisterFactory().setup();
  //init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(
    UserAdapter(),
  );
  //init our user Box
  await HiveManager().initBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

//Basic UI to serve as a demo for Hive
//User present in Hive = Show Details
//User is not present in Hive = Show button

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserBloc _bloc = sl.get<UserBloc>();

  User? _user = HiveManager().getCurrentUser();

  void updateUser() {
    //current user is retrieved from our Box, and assigned to the user variable
    final User? user = HiveManager().getCurrentUser();
    _user = user;
    //update UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (context, state) {
        //if user is added to Hive call updateUser() function
        if (state is UserAddedState) {
          updateUser();
        }
      },
      child: Scaffold(
        body: Center(
          child: _user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_user!.name),
                    Text(_user!.id),
                    Text(_user!.age.toString())
                  ],
                )
              : Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      _bloc.add(
                        AddUserToHive(
                            name: 'Robert', id: 'gfegergregre1234', age: 22),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Add user'),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
