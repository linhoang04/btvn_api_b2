import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';

class PostManager{
  final Client client = Client();
  Future<List<Post>> getPosts ()async{ 
    final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    final data = jsonDecode(response.body) as List;
    final posts = data.map((e){
      final postData = e as Map<String, dynamic>;
      final post = Post(
        userId: postData["userId"],
        id: postData["id"],
        title: postData["title"],
        body: postData["body"]
      );
    return post;
    }).toList();
    return posts;
  }
/*id": 1,
"name": "Leanne Graham",
"username": "Bret",
"email": "Sincere@april.biz",*/
  Future<User?> getPostById (int id)async {
    final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users/$id"));
    final data = jsonDecode(response.body);
    if (data != null) { 
      final userData = data as Map<String, dynamic> ;
      final user = User( 
        id: userData["id"], 
        name: userData["name"], 
        username: userData["username"], 
        email: userData["email"], 
      ); 
      return user; 
    } 
    return null; 
  } 


/*{
    "postId": 1,
    "id": 1,
    "name": "id labore ex et quam laborum",
    "email": "Eliseo@gardner.biz",
    "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
  },
*/

Future<Commants?> getCommants(int id) async {
  final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/comments/$id"));
  final data = jsonDecode(response.body);
  if(data != null){
    final getData = data as Map<String, dynamic>;
    var commant = Commants(
      postId: getData["postId"],
      id: getData["id"],
      name: getData["name"],
      email: getData["email"],
      body: getData["body"],
    );
    return commant;
  }
  return null;
  }
}

void main(List<String> arguments) async {
  var postManager = PostManager();
  var posts = await postManager.getPosts();
  // print(posts);
  String? id = stdin.readLineSync();
  int p = int.parse(id!); 
  var post = posts.firstWhere((post) => post.id == p);
  var user = await postManager.getPostById(post.id);
  // var user = await postManager.getPostById(${post.id});
  if (user != null) { 
      print('User ID: ${user.id}'); 
      print('Name: ${user.name}'); 
      print('Username: ${user.username}'); 
      print('Email: ${user.email}'); 
    } 
  var commant = await postManager.getCommants(post.id);
  if (commant != null) {
    print("Commant ID: ${commant.id}");
    print("Name: ${commant.name}");
    print("Body: ${commant.body}");
  }
}
class Commants{
  int postId;
  int id;
  String name;
  String email;
  String body;

  Commants({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
} 


class User {
  int id;
  String name;
  String username;
  String email;

  User({required this.id, required this.name, required this.username, required this.email});
}
class Post{
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}


