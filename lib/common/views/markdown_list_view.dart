import 'package:flutter/material.dart';

class MarkdownListView extends StatefulWidget {
  const MarkdownListView({super.key, this.markdowns});

  final List<String>? markdowns;

  @override
  State<MarkdownListView> createState() => _MarkdownListViewState();
}

class _MarkdownListViewState extends State<MarkdownListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.markdowns == null) {
      return const Center(child: Text('Look forward to it!'));
    }
    return ListView.separated(
      itemCount: widget.markdowns!.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(widget.markdowns![index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
