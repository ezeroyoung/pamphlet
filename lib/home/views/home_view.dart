import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pamphlet/home/views/home_endside_bar.dart';
import 'package:provider/provider.dart';

import '../../common/views/markdown_scaffold.dart';
import '../providers/home_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      builder: (context, child) => _buildView(context),
    );
  }

  Widget _buildView(BuildContext context) {
    final provider = context.read<HomeProvider>();
    final state = provider.state;

    return PlatformMenuBar(
      // 顶部操作栏
      menus: state.menusItems,
      child: MacosWindow(
        // 左侧边栏
        sidebar: Sidebar(
          // 顶部搜索框
          top: MacosSearchField(
            placeholder: 'Search',
            controller: state.searchFieldController,
            onResultSelected: (result) => provider.searchFieldAction(result),
            results: state.searchResultItems,
          ),
          minWidth: 200,
          // 中间items
          builder: (context, scrollController) {
            return Consumer<HomeProvider>(
              builder: (context, provider, child) => SidebarItems(
                  currentIndex: state.pageIndex,
                  onChanged: (i) => provider.updateIndex(i),
                  scrollController: scrollController,
                  itemSize: SidebarItemSize.large,
                  items: state.sideBarItems),
            );
          },
          // 底部视图
          bottom: const MacosListTile(
            leading: MacosIcon(CupertinoIcons.profile_circled),
            title: Text('Zero young'),
            subtitle: Text('e.zero.young@gmail.com'),
          ),
        ),
        // 右侧边栏
        endSidebar: HomeEndSideBar(),
        // 中间items对应的markdown展示页
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return CupertinoTabView(
              builder: (_) => MarkdownScaffold(
                name: state.searchResultNames[state.pageIndex],
                index: state.pageIndex,
              ),
            );
          },
        ),
      ),
    );
  }
}
