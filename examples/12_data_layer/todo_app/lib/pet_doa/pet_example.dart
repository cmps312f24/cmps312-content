import 'package:todoapp/entities/owner.dart';
import 'package:todoapp/entities/pet.dart';
import 'package:todoapp/pet_doa/pet_dao.dart';

void main() async {
  final database = await $FloorPetDatabase.databaseBuilder('petdb.db').build();

  final petDao = database.petDao;

  // Insert example data
  final owner = Owner(id: 1, name: 'John Doe');
  final pet = Pet(id: 1, name: 'Buddy', ownerId: 1);

  await database.ownerDao.insertOwner(owner);
  await database.petDao.insertPet(pet);

  // Fetch data using the view
/*   final petsWithOwners = await petDao.getAllPetsWithOwners();
  for (var item in petsWithOwners) {
    print('${item.pet.name} belongs to ${item.owner.name}');
  } */

  // Fetch data using the view
  final petsOwners = await petDao.getPetOwners();
  for (var item in petsOwners) {
    print('${item.petName} belongs to ${item.ownerName}');
  }
}
