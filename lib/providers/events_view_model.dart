
import 'package:flutter/foundation.dart';

import '../models/event.dart';
import '../repository/events_repository.dart';

class EventsViewModel with ChangeNotifier {
  EventsRepository _repository;

  EventsViewModel(this._repository);

  void addEvent(Event event) async {
    await _repository.addEvent(event);
    notifyListeners();
  }

  Future<List<Event>> listAllEvents(String eventType) {
    return _repository.listByEventType(eventType);
  }

  void deleteEvent(Event event) async {
    await _repository.deleteEvent(event);
    notifyListeners();
  }
}