import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pamphlet/common/providers/markdown_provider.dart';
import 'package:pamphlet/common/views/markdown_list_view.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';

class MarkdownScaffold extends StatefulWidget {
  const MarkdownScaffold({super.key, required this.name, required this.index});

  final String name;
  final int index;

  @override
  State<MarkdownScaffold> createState() => _MarkdownScaffoldState();
}

class _MarkdownScaffoldState extends State<MarkdownScaffold> {
  late MarkdownProvider _provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MarkdownProvider(),
      builder: (context, child) => _buildView(context),
    );
  }

  Widget _buildView(BuildContext context) {
    final provider = context.read<MarkdownProvider>();
    final state = provider.state;
    return MacosScaffold(
      toolBar: ToolBar(
        title: Text(widget.name),
        titleWidth: 150.0,
        leading: MacosTooltip(
          message: 'Toggle Sidebar',
          useMousePosition: false,
          child: MacosIconButton(
            icon: MacosIcon(
              CupertinoIcons.sidebar_left,
              color: MacosTheme.brightnessOf(context).resolve(
                const Color.fromRGBO(0, 0, 0, 0.5),
                const Color.fromRGBO(255, 255, 255, 0.5),
              ),
              size: 20.0,
            ),
            boxConstraints: const BoxConstraints(
              minHeight: 20,
              minWidth: 20,
              maxWidth: 48,
              maxHeight: 38,
            ),
            onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
          ),
        ),
        actions: [
          ToolBarIconButton(
            label: 'Toggle End Sidebar',
            tooltipMessage: 'Toggle End Sidebar',
            icon: const MacosIcon(
              CupertinoIcons.sidebar_right,
            ),
            onPressed: () => MacosWindowScope.of(context).toggleEndSidebar(),
            showLabel: false,
          ),
        ],
      ),
      children: [
        ResizablePane(
          minSize: 180,
          startSize: 200,
          windowBreakpoint: 700,
          resizableSide: ResizableSide.right,
          builder: (context, _) {
            final markdowns = context.watch<MarkdownProvider>().state.markdowns;
            if (markdowns != null && markdowns.isNotEmpty) {
              return MarkdownListView(
                markdowns: markdowns,
              );
            }
            return const MarkdownListView();
          },
        ),
        ContentArea(
          builder: (context, scrollController) {
            provider.getMarkdownFileContent(widget.name, context);

            final appTheme = context.watch<AppTheme>();
            final platformBrightness = MediaQuery.platformBrightnessOf(context);
            final useDarkTheme = appTheme.mode == ThemeMode.dark ||
                (appTheme.mode == ThemeMode.system &&
                    platformBrightness == Brightness.dark);
            return Consumer<MarkdownProvider>(
                builder: (context, value, child) => Theme(
                    data: useDarkTheme ? ThemeData.dark() : ThemeData.light(),
                    child: Markdown(data: state.markdownContent)));
            return Theme(
                data: useDarkTheme ? ThemeData.dark() : ThemeData.light(),
                child: Markdown(data: state.markdownContent));
          },
        ),
        ResizablePane(
          minSize: 180,
          startSize: 200,
          windowBreakpoint: 800,
          resizableSide: ResizableSide.left,
          builder: (_, __) {
            return const Center(
              child: Text('Look forward to it!'),
            );
          },
        ),
      ],
    );
  }
}
