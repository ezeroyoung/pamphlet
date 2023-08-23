import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

import '../states/home_state.dart';

class HomeProvider extends ChangeNotifier {
  final state = HomeState();

  void updateIndex(int index) {
    state.pageIndex = index;
    notifyListeners();
  }

  void searchFieldAction(SearchResultItem result) {
    int pageIndex = state.searchResultNames.indexOf(result.searchKey);
    state.pageIndex = pageIndex;
    state.searchFieldController.clear();
    notifyListeners();
  }
}
