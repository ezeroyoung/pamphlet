import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlet/common/states/markdown_state.dart';

import '../../utils/utils.dart';
import '../consts.dart';

class MarkdownProvider extends ChangeNotifier {
  final state = MarkdownState();

  /// Get all markdown files in a directory
  _getAllMarkdownFiles(String name, BuildContext context) async {
    final markdowns = state.markdowns;
    if (markdowns != null && markdowns.isNotEmpty) {
      return;
    }
    // Get the directory path.
    final dirPath = '$kResourcesMarkdownsPath/$name';
    // Load as String
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    // Decode to Map
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // Get all files in the specified directory
    final List<String> files =
        manifestMap.keys.where((path) => path.startsWith(dirPath)).toList();
    state.markdowns = files.map((e) {
      return e.split('/').last.split('.').first;
    }).toList();
  }

  /// Get markdown content with fileName and categoryName.
  getMarkdownFileContent(String categoryName, BuildContext context) async {
    if (state.markdownCurrentCategory == categoryName &&
        state.markdownContentCurrentIndex ==
            state.markdownContentPreviousIndex) {
      return;
    }
    if (state.markdownCurrentCategory != categoryName) {
      state.markdowns = null;
      state.markdownCurrentCategory == categoryName;

      state.markdownContentPreviousIndex = -1;
      state.markdownContentCurrentIndex = 0;
      state.markdownContent = 'Look forward to it!';
    }
    if (state.markdownContentCurrentIndex !=
        state.markdownContentPreviousIndex) {
      state.markdownContentPreviousIndex = state.markdownContentCurrentIndex;
      state.markdownContent = 'Look forward to it!';
    }
    if (state.markdowns == null) {
      await _getAllMarkdownFiles(categoryName, context);
    }
    final markdowns = state.markdowns;
    if (markdowns == null) {
      notifyListeners();
      return;
    }
    if (markdowns.isEmpty) {
      notifyListeners();
      return;
    }
    if (state.markdownContentCurrentIndex >= markdowns.length) {
      notifyListeners();
      return;
    }
    final fileName = markdowns[state.markdownContentCurrentIndex];
    final cachedMarkdownContent = state.cachedMarkdownContents[fileName];
    if (cachedMarkdownContent != null) {
      state.markdownContent = cachedMarkdownContent;
      _configHeadingsKey();
      notifyListeners();
      return;
    }
    String markdownFilePath =
        '$kResourcesMarkdownsPath/$categoryName/$fileName.md';
    if (context.mounted) {
      var markdownContent =
          await DefaultAssetBundle.of(context).loadString(markdownFilePath);
      markdownContent = Utils.addHeadingNumbers(markdownContent);
      state.cachedMarkdownContents[fileName] = markdownContent;
      state.markdownContent = markdownContent;
      _configHeadingsKey();
      notifyListeners();
    }
  }

  void _configHeadingsKey() {
    final extractHeadings = Utils.extractHeadings(state.markdownContent);
    for (var heading in extractHeadings) {
      final key = heading.replaceAll('#', '').trim();
      state.markdownHeadingsKey[key] = GlobalKey(debugLabel: key);
    }
  }

  void scrollToKey(String keyName) {
    if (keyName == state.currentKeyName) {
      return;
    }
    state.currentKeyName = keyName;
    GlobalKey? key = state.markdownHeadingsKey[keyName];
    if (key != null) {
      final keyContext = key.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        final dy = box.localToGlobal(Offset.zero).dy;
        if (kDebugMode) {
          print(state.scrollController.offset);
          print(dy);
        }
        state.scrollController.animateTo(
          dy,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
