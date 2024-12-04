class ChequeImage {
  int id;
  String image;

  ChequeImage({required this.id, required this.image});

  @override
  String toString() {
    return 'ChequeImage{id: $id, image: $image}';
  }
}