import 'package:pamphlet/common/models/markdown_file_model.dart';

class CategoryModel {
  CategoryModel({required this.name, this.markdowns});

  final String name;
  final List<MarkdownFileModel>? markdowns;
}
