import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedCategoryNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void setCategory(String? category) {
    state = category;
  }
}

final selectedCategoryProvider = NotifierProvider<SelectedCategoryNotifier, String?>(
  () => SelectedCategoryNotifier(),
);