class Utils {
  /// Extract the directory from the markdown document.
  static List<String> extractHeadings(String markdownData) {
    final RegExp regExp = RegExp(r'(#+)\s+(.*)');
    final matches = regExp.allMatches(markdownData);
    List<String> headings = [];
    for (var match in matches) {
      final String symbol = match.group(1)!; // #, ##, ###, ...
      final String title = match.group(2)!;
      headings.add("$symbol $title");
    }
    return headings;
  }

  static String addHeadingNumbers(String markdown) {
    List<int> counters = [0, 0, 0, 0, 0, 0];

    // 修改正则表达式以捕获可能存在的目录标号
    RegExp exp = RegExp(r'^(#+) ([\d.]*)(\s*.+)$', multiLine: true);

    return markdown.replaceAllMapped(exp, (Match match) {
      int level = match.group(1)!.length;

      // 获取可能存在的目录标号
      String existingNumber = match.group(2)!;

      // 如果已经有目录标号，则不添加新的标号
      if (existingNumber.isNotEmpty) {
        return match.group(0)!;
      }

      // 重置更高级别的计数
      for (int i = level; i < counters.length; i++) {
        counters[i] = 0;
      }

      // 更新当前级别的计数
      counters[level - 1]++;

      // 创建新的目录标号
      String number = counters.sublist(0, level).join(".");

      // 返回更新后的标题行
      return "${match.group(1)} $number${match.group(3)}";
    });
  }
}
