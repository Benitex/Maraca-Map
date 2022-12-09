import 'package:flutter_riverpod/flutter_riverpod.dart';

final pointOfInterestListProvider = NotifierProvider<PointOfInterestListsNotifier, Map<String, List<String>>>(() {
  return PointOfInterestListsNotifier();
});

class PointOfInterestListsNotifier extends Notifier<Map<String, List<String>>> {
  @override
  Map<String, List<String>> build() => {
    "Favoritos": [],
    "Vou visitar": [],
  };

  void addList({required String listName, List<String>? list}) {
    state = {...state, listName: list ?? []};
  }

  void removeList(String listName) {
    Map<String, List<String>> lists = {};

    state.forEach((key, list) {
      if (key != listName) lists[key] = list;
    });

    state = lists;
  }

  void addPointOfInterestTo({required String listName, required String id}) {
    Map<String, List<String>> lists = {};

    state.forEach((key, list) {
      if (key == listName) {
        lists[key] = [...list, id];
      } else {
        lists[key] = list;
      }
    });

    state = lists;
  }

  void removePointOfInterestFrom({required String listName, required String removedId}) {
    if (state.containsKey(listName)) {
      state[listName] = [
        for (String id in state[listName]!)
          if (id != removedId) id,
      ];
    }
  }
}
