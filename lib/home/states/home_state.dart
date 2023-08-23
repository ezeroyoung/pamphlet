import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pamphlet/home/models/home_sidebar_item_model.dart';

class HomeState {
  int pageIndex = 0;

  late final TextEditingController searchFieldController;
  late final List<String> searchResultNames;
  late final List<SearchResultItem> searchResultItems;

  late final List<PlatformMenuItem> menusItems;

  late final List<SidebarItem> sideBarItems;

  HomeState() {
    // TextEditingController
    searchFieldController = TextEditingController();
    // Menu items
    menusItems = [
      const PlatformMenu(
        label: 'macos_ui Widget Gallery',
        menus: [
          PlatformProvidedMenuItem(
            type: PlatformProvidedMenuItemType.about,
          ),
          PlatformProvidedMenuItem(
            type: PlatformProvidedMenuItemType.quit,
          ),
        ],
      ),
      const PlatformMenu(
        label: 'View',
        menus: [
          PlatformProvidedMenuItem(
            type: PlatformProvidedMenuItemType.toggleFullScreen,
          ),
        ],
      ),
      const PlatformMenu(
        label: 'Window',
        menus: [
          PlatformProvidedMenuItem(
            type: PlatformProvidedMenuItemType.minimizeWindow,
          ),
          PlatformProvidedMenuItem(
            type: PlatformProvidedMenuItemType.zoomWindow,
          ),
        ],
      ),
    ];
    // Side items
    var sideItemModels = [
      HomeSidebarItemModel(name: 'iOS', trailingName: '3', disclosureItems: [
        HomeSidebarItemModel(name: 'ObjectiveC'),
        HomeSidebarItemModel(name: 'Swift'),
        HomeSidebarItemModel(name: 'SwiftUI')
      ]),
      HomeSidebarItemModel(
          name: 'Android',
          trailingName: '3',
          disclosureItems: [
            HomeSidebarItemModel(name: 'Java'),
            HomeSidebarItemModel(name: 'Kotlin'),
            HomeSidebarItemModel(name: 'Compose')
          ]),
      HomeSidebarItemModel(
          name: 'Flutter',
          trailingName: '2',
          disclosureItems: [
            HomeSidebarItemModel(name: 'Dart'),
            HomeSidebarItemModel(name: 'Flutter')
          ]),
      HomeSidebarItemModel(
          name: '软考',
          trailingName: '1',
          disclosureItems: [HomeSidebarItemModel(name: '系统分析师')])
    ];

    initOtherThroughSideMenu(sideItemModels);
  }

  void initOtherThroughSideMenu(List<HomeSidebarItemModel> sideItemModels) {
    sideBarItems = sideItemModels.map((e) {
      bool hasDisclosureItems = e.disclosureItems != null;
      if (hasDisclosureItems) {
        return SidebarItem(
            leading: const MacosIcon(CupertinoIcons.folder),
            label: Text(e.name),
            disclosureItems: e.disclosureItems!
                .map((e) => SidebarItem(
                    leading: const MacosIcon(CupertinoIcons.book),
                    label: Text(e.name)))
                .toList());
      }
      return SidebarItem(label: Text(e.name));
    }).toList();

    var resultNames = <String>[];
    var resultItems = <SearchResultItem>[];

    void addResults(HomeSidebarItemModel e) {
      resultNames.add(e.name);
      resultItems.add(SearchResultItem(e.name));
    }

    for (var e in sideItemModels) {
      bool hasDisclosureItems = e.disclosureItems != null;
      if (hasDisclosureItems) {
        for (var e in e.disclosureItems!) {
          addResults(e);
        }
      } else {
        addResults(e);
      }
    }
    searchResultNames = resultNames;
    searchResultItems = resultItems;
  }
}
