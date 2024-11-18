import 'package:db_example/pet_example.dart';

void main() async {
  final database = await $PetDatabase.databaseBuilder('petdb.db').build();

  final petDao = database.petDao;

  // Insert example data
  final owner = Owner(id: 1, name: 'John Doe');
  final pet = Pet(id: 1, name: 'Buddy', ownerId: 1);

  await database.ownerDao.insertOwner(owner);
  await database.petDao.insertPet(pet);

  // Fetch data using the view
  final petsWithOwners = await petDao.getAllPetsWithOwners();
  for (var item in petsWithOwners) {
    print('${item.pet.name} belongs to ${item.owner.name}');
  }

  // Fetch data using the view
  final petsOwners = await petDao.getAllPetsWithOwners();
  for (var item in petsOwners) {
    print('${item.petName} belongs to ${item.ownerName}');
  }
}
