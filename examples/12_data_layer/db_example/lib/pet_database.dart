import 'package:db_example/pet_example.dart';
import 'package:floor/floor.dart';

@Database(version: 1, entities: [Owner, Pet])
abstract class PetDatabase extends FloorDatabase {
  PetDao get petDao;
  // Add other DAOs here
}
