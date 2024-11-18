import 'package:floor/floor.dart';

@entity
class Owner {
  @PrimaryKey(autoGenerate: false)
  final int id; // Primary key
  final String name;

  Owner({required this.id, required this.name});
}

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['ownerId'], // Column in this entity
      parentColumns: ['id'], // Column in the parent entity
      entity: Owner,
      onDelete: ForeignKeyAction.cascade, // Cascade deletion
    ),
  ],
  indices: [
    Index(value: ['ownerId']), // Index on ownerId for query performance
  ],
)
class Pet {
  @PrimaryKey(autoGenerate: false)
  final int id; // Primary key
  final String name;
  final int ownerId; // Foreign key linking to the Owner table

  Pet({required this.id, required this.name, required this.ownerId});
}

// Composite object for Pet with its Owner
class PetWithOwner {
  final Pet pet;
  final Owner owner;

  PetWithOwner({required this.pet, required this.owner});
}

@DatabaseView(
  'SELECT Pet.name AS petName, Owner.name AS ownerName '
  'FROM Pet INNER JOIN Owner ON Pet.ownerId = Owner.id',
  viewName: 'PetWithOwnerView',
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

  @Query('SELECT * FROM Pet INNER JOIN Owner ON Pet.ownerId = Owner.id')
  Future<List<PetWithOwner>> getAllPetsWithOwners();

  @Query('SELECT * FROM PetWithOwnerView')
  Future<List<PetOwner>> getPetsWithOwners();
}

@dao
abstract class OwnerDao {
  @insert
  Future<void> insertOwner(Owner owner);
}
