import 'package:flutter/material.dart';

class ChipProvider extends ChangeNotifier {
  Map<String, Widget> chips = {};

  addChip({String key, Widget chip}) {
    chips.putIfAbsent(key, () => chip);
    notifyListeners();
  }

  removeChip(String key) {
    chips.remove(key);
    notifyListeners();
  }

  List<Widget> getChips() {
    return chips.values.toList();
  }
}
