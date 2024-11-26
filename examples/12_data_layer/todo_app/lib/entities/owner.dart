import 'package:floor/floor.dart';

@entity
class Owner {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;

  Owner({required this.id, required this.name});
}