import 'package:floor/floor.dart';
import 'package:todoapp/entities/owner.dart';
import 'package:todoapp/entities/pet.dart';

/*@DatabaseView(
  'SELECT * '
  'FROM Pet as p INNER JOIN Owner as o ON p.ownerId = o.id',
  viewName: 'PetWithOwnerView',
)
// Composite object for Pet with its Owner
class PetWithOwner {
  final Pet pet;
  final Owner owner;

  PetWithOwner({required this.pet, required this.owner});
}*/

@DatabaseView(
  'SELECT p.name AS petName, o.name AS ownerName '
  'FROM Pet as p INNER JOIN Owner as o ON p.ownerId = o.id',
  viewName: 'PetOwnerView',
)
class PetOwner {
  final String petName;
  final String ownerName;

  PetOwner({required this.petName, required this.ownerName});
}

// DAO to fetch data
@dao
abstract class PetDao {
  @insert
  Future<void> insertPet(Pet pet);

  //@Query('SELECT * FROM PetWithOwnerView')
  //Future<List<PetWithOwner>> getPetsWithOwners();

  @Query('SELECT * FROM PetWithOwnerView')
  Future<List<PetOwner>> getPetOwners();
}

@dao
abstract class OwnerDao {
  @insert
  Future<void> insertOwner(Owner owner);
}
