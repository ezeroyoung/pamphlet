import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownHeaderBuilder extends MarkdownElementBuilder {
  final Map<String, GlobalKey> keys;

  MarkdownHeaderBuilder(this.keys);

  @override
  void visitElementBefore(md.Element element) {
    // TODO: implement visitElementBefore
    super.visitElementBefore(element);
  }

  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    final key = keys[text.text];
    if (kDebugMode) {
      print(key);
    }
    return Container(
      color: Colors.orange,
      key: key,
      child: DefaultTextStyle.merge(
        style: preferredStyle!,
        child: Text(text.text),
      ),
    );
  }
}
