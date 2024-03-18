// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelStory {
  String title;
  String description;
  String content;
  String articleLink;
  String date;
  String? imageURL;
  
  
  ModelStory({
    required this.title,
    required this.description,
    required this.content,
    required this.articleLink,
    required this.date,
    required this.imageURL,
  });

  ModelStory copyWith({
    String? title,
    String? description,
    String? content,
    String? articleLink,
    String? date,
    String? imageURL,
  }) {
    return ModelStory(
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      articleLink: articleLink ?? this.articleLink,
      date: date ?? this.date,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'content': content,
      'articleLink': articleLink,
      'date': date,
      'imageURL': imageURL,
    };
  }

  factory ModelStory.fromMap(Map<String, dynamic> map) {
    return ModelStory(
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      articleLink: map['articleLink'] as String,
      date: map['date'] as String,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelStory.fromJson(String source) => ModelStory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ModelStory(title: $title, description: $description, content: $content, articleLink: $articleLink, date: $date, imageURL: $imageURL)';
  }

  @override
  bool operator ==(covariant ModelStory other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.content == content &&
      other.articleLink == articleLink &&
      other.date == date &&
      other.imageURL == imageURL;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      content.hashCode ^
      articleLink.hashCode ^
      date.hashCode ^
      imageURL.hashCode;
  }
}
