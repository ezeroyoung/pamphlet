import 'package:flutter/material.dart';
import 'package:pamphlet/utils/utils.dart';
import 'package:provider/provider.dart';

import '../providers/markdown_provider.dart';

class MarkdownHeadingsView extends StatefulWidget {
  const MarkdownHeadingsView(
      {super.key,
      required this.markdownContent,
      required this.scrollController});

  final String markdownContent;
  final ScrollController scrollController;

  @override
  State<MarkdownHeadingsView> createState() => _MarkdownHeadingsViewState();
}

class _MarkdownHeadingsViewState extends State<MarkdownHeadingsView> {
  List<String>? _headings;

  @override
  Widget build(BuildContext context) {
    _headings = Utils.extractHeadings(widget.markdownContent);
    if (_headings == null) {
      return const Center(child: Text('Look forward to it!'));
    }
    return ListView.separated(
      controller: widget.scrollController,
      itemCount: _headings!.length,
      itemBuilder: (context, index) {
        String heading = _headings![index];
        final matches = heading.split('#');
        var matchesCount = 0;
        if (matches.isNotEmpty) {
          matchesCount = matches.length - 1;
        }
        final text = _headings![index].replaceAll('#', '').trim();
        return GestureDetector(
          onTap: () {
            final provider = context.read<MarkdownProvider>();
            provider.scrollToKey(text);
          },
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: EdgeInsets.only(left: matchesCount * 5),
                child: Text(text),
              )),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
