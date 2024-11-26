import 'package:todoapp/entities/owner.dart';
import 'package:floor/floor.dart';

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
    // Index on ownerId to improve query performance
    Index(value: ['ownerId']),
  ],
)
class Pet {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final int ownerId; // Foreign key linking to the Owner table

  Pet({required this.id, required this.name, required this.ownerId});
}
