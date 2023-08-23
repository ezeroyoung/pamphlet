class HomeSidebarItemModel {
  HomeSidebarItemModel(
      {required this.name, this.trailingName, this.disclosureItems});
  String name;
  String? trailingName;
  List<HomeSidebarItemModel>? disclosureItems;
}
