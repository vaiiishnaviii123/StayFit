import 'package:flutter/foundation.dart';
import 'package:stay_fit/Models/event.dart';

class WorkoutList with ChangeNotifier {
  late List<Event> list;

  WorkoutList(this.list);

  List<Event> getWorkoutList() {
    return this.list.toList();
  }

  void addWorkoutToList(Event event) {
    list.add(event);
    notifyListeners();
  }
}