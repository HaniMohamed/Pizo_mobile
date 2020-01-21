import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizo/models/conversation.dart';
import 'package:pizo/models/message.dart';
import 'package:pizo/resources/constants.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;

Constants cons = new Constants();

class MessagesAPI {
  Future createConversation(token, receiverID, title) async {
    http.Response response = await http.post(
        cons.domain + "/api/v1/messages/create?token=" + token,
        body: {"title": title, "receiver": receiverID});
    final decoded = JSON.jsonDecode(response.body);
    var error = decoded['error'];
    print(decoded['error']);
    if (error == 1) {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    } else if (error == 0) {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      return decoded['id'];
    }
    return null;
  }

  Future<List<Message>> getMessages(token, id) async {
    String url = cons.domain +
        "api/v1/messages/" +
        id.toString() +
        "/messages?token=" +
        token;
    http.Response response = await http.get(url);
    final decoded = JSON.jsonDecode(response.body.toString());
    var list = decoded['messages'] as List;
    List<Message> messages = list.map((i) => Message.fromJson(i)).toList();
    var error = decoded['error'];
    if (error == 1) {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    } else if (error == 0) {
      return messages;
    }
    return null;
  }

  Future<String> sndMessage(token, id, msg) async {
    String url = cons.domain +
        "api/v1/messages/" +
        id.toString() +
        "/send?token=" +
        token;
    http.Response response = await http.post(url, body: {"message": msg});
    final decoded = JSON.jsonDecode(response.body.toString());
    var error = decoded['error'];
    return error.toString();
  }

  Future<List<Conversation>> getConversations(token) async {
    String url = cons.domain + "/api/v1/messages?token=" + token;
    http.Response response = await http.get(url);
    final decoded = JSON.jsonDecode(response.body.toString());
    var list = decoded['conversation'] as List;
    List<Conversation> conversations =
        list.map((i) => Conversation.fromJson(i)).toList();
    var error = decoded['error'];
    if (error == 1) {
      Fluttertoast.showToast(
          msg: decoded['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    } else if (error == 0) {
      return conversations;
    }
    return null;
  }
}
