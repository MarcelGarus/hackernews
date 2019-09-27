import 'dart:convert';

import 'package:meta/meta.dart';

class UnsupportedItemError implements Exception {
  final String itemType;

  UnsupportedItemError(this.itemType);

  String toString() => 'Unsupported item type itemType.';
}

@immutable
abstract class Item {
  final String id;
  final String author;
  final DateTime created;

  Item({
    @required this.id,
    @required this.author,
    @required this.created,
  })  : assert(id != null),
        assert(author != null),
        assert(created != null);

  factory Item.fromJson(dynamic jsonString) {
    Map<String, dynamic> data = json.decode(jsonString);
    if (data['type'] == 'story') {
      return Story(
        id: data['id'],
        author: data['by'],
        created: DateTime.fromMillisecondsSinceEpoch(int.parse(data['time'])),
        title: data['title'],
        text: data['text'],
        url: data['url'],
        score: data['score'],
        numComments: data['descendants'],
        topLevelCommentIds: data['kids'],
      );
    } else if (data['type'] == 'comment') {
      return Comment(
        id: data['id'],
        author: data['by'],
        created: DateTime.fromMillisecondsSinceEpoch(int.parse(data['time'])),
        text: data['text'],
        parent: data['parent'],
      );
    } else {
      throw UnsupportedItemError(data['type']);
    }
  }
}

@immutable
class Story extends Item {
  final String title;
  final String text;
  final String url;
  final int score;
  final int numComments;
  final List<String> topLevelCommentIds;

  Story({
    @required String id,
    @required String author,
    @required DateTime created,
    @required this.title,
    @required this.text,
    @required this.url,
    @required this.score,
    @required this.numComments,
    @required this.topLevelCommentIds,
  })  : assert(title != null),
        assert(text != null),
        assert(url != null),
        assert(score != null),
        assert(numComments != null),
        assert(topLevelCommentIds != null),
        super(id: id, author: author, created: created);
}

@immutable
class Comment extends Item {
  final String parent;
  final String text;

  Comment({
    @required String id,
    @required String author,
    @required DateTime created,
    @required this.parent,
    @required this.text,
  })  : assert(parent != null),
        assert(text != null),
        super(id: id, author: author, created: created);
}
