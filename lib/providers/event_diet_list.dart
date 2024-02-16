import 'package:flutter/foundation.dart';
import 'package:stay_fit/models/event.dart';

class DietList with ChangeNotifier {
  late List<Event> list;

  DietList(this.list);

  List<Event> getDietList() {
    return this.list.toList();
  }

  void addDietToList(Event event) {
    list.add(event);
    notifyListeners();
  }
}