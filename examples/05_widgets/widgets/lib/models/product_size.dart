// Define the enum class for ProductSize with a label property
enum ProductSize {
  extraSmall('XS'),
  small('S'),
  medium('M'),
  large('L'),
  extraLarge('XL');

  final String label;

  const ProductSize(this.label);
}