import 'package:voumarketinggame/models/events_model.dart';

class GlobalEvent {
  // Private constructor
  GlobalEvent._privateConstructor();

  // Singleton instance
  static final GlobalEvent _instance = GlobalEvent._privateConstructor();

  // Getter for singleton instance
  static GlobalEvent get instance => _instance;

  // The current EventModel
  EventModel? currentEvent;

  // Method to set the current event
  void setCurrentEvent(EventModel event) {
    currentEvent = event;
  }

  // Method to get the current event
  EventModel? getCurrentEvent() {
    return currentEvent;
  }

  // Clear the stored event
  void clearEvent() {
    currentEvent = null;
  }
}
