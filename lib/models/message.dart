class Message {
  int id, senderID;
  String message, date;
  Message({this.id, this.senderID, this.message, this.date});

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
        id: parsedJson['id'],
        message: parsedJson['message'],
        senderID: parsedJson['sender_id'],
        date: parsedJson['created_at']);
  }

  getID() {
    return id;
  }

  getSenderID() {
    return senderID;
  }

  getMessage() {
    return message;
  }

  getDate() {
    return date;
  }
}
