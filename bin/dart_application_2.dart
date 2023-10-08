import 'dart:io';

import 'package:dart_application_2/dart_application_2.dart' as dart_application_2;
import 'package:dart_application_2/dart_application_2.dart';
import 'package:test/test.dart';

void main(List<String> arguments) async {
  var postManager = PostManager();
  var posts = await postManager.getPosts();
  // print(posts);
  String? id = stdin.readLineSync();
  int p = int.parse(id!); 
  var post = posts.firstWhere((post) => post.id == p);
  var user = await postManager.getPostById(post.id);
  print('UserId:${user.id}');
  print('Name:${user.name}');
  print('Name:${user.username}');
  print('Name:${user.email}');
}
