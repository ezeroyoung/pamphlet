import 'package:flutter/cupertino.dart';

class MarkdownState {
  String markdownContent = 'Look forward to it!';

  String currentKeyName = '';

  List<String>? markdowns;

  String markdownCurrentCategory = '';
  int markdownContentPreviousIndex = -1;
  int markdownContentCurrentIndex = 0;

  late Map<String, String> cachedMarkdownContents;
  late Map<String, GlobalKey> markdownHeadingsKey;

  late ScrollController scrollController;

  MarkdownState() {
    cachedMarkdownContents = <String, String>{};
    markdownHeadingsKey = <String, GlobalKey>{};
  }
}
