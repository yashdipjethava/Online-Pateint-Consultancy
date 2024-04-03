
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;

class BlogModel {
  String? categoryName;
  String? topicName;
  String? description;
  String? blogImage;

  BlogModel({
    this.categoryName,
    this.topicName,
    this.description,
    this.blogImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'description': description,
      'topicName': topicName,
      'blogImage': blogImage,
    };
  }

  BlogModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      :
        categoryName = doc.data()?['categoryName'],
        description = doc.data()?['description'],
        topicName = doc.data()?['topicName'],
        blogImage = doc.data()?['blogImage'];


  BlogModel copyWith({
    String? categoryName,
    String? description,
    String? topicName,
    String? blogImage,
  }) {
    return BlogModel(
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      topicName: topicName ?? this.topicName,
      blogImage: blogImage ?? this.blogImage,
    );
  }
}
