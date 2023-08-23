import 'package:pamphlet/api/github/github_model.dart';
import 'package:pamphlet/network/request.dart';

class GithubAPI {}

extension GithubAPIUser on GithubAPI {}

class User {
  final String path = '/user';
  get request => Request<UserModel>(path);
}
