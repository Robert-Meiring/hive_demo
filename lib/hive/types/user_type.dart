import 'package:hive/hive.dart';
part 'user_type.g.dart';

//User entity rigged for Hive
//TypeAdapter is used for our Hive to store objects

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final int age;

  User({required this.name, required this.id, required this.age});
}
