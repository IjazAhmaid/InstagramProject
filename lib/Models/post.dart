import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;
  Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.profImage,
    required this.postUrl,
    required this.likes,
  });
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postUrl": postUrl,
        "username": username,
        "datePublished": datePublished,
        "postId": postId,
        "likes": likes,
        "profImage": profImage
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        username: snapshot['username'],
        description: snapshot['description'],
        uid: snapshot['uid'],
        postUrl: snapshot['postUrl'],
        datePublished: snapshot['datePublished'],
        postId: snapshot['postId'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']);
  }
}
