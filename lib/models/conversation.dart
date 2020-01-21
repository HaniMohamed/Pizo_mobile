class Conversation {
  String title;
  int id, user1, user2;

  Conversation({this.id, this.title, this.user1, this.user2});

  factory Conversation.fromJson(Map<String, dynamic> parsedJson) {
    return Conversation(
        id: parsedJson['id'],
        title: parsedJson['title'],
        user1: parsedJson['user1'],
        user2: parsedJson['user2']);
  }

  getID() {
    return id;
  }

  getTitle() {
    title = title.substring(title.indexOf(">") + 1, title.length);
    return title;
  }

  getUser1() {
    return user1;
  }

  getUser2() {
    return user2;
  }
}
