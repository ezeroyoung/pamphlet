class MarkdownState {
  String markdownContent = 'Look forward to it!';
  List<String>? markdowns;
  late Map<String, String> cachedMarkdownContents;
  String markdownCurrentCategory = '';
  int markdownContentPreviousIndex = -1;
  int markdownContentCurrentIndex = 0;

  MarkdownState() {
    cachedMarkdownContents = <String, String>{};
  }
}
