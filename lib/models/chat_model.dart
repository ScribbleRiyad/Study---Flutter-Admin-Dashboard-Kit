import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:study/helpers/services/json_decoder.dart';
import 'package:study/images.dart';
import 'package:study/models/identifier_model.dart';

class ChatModel extends IdentifierModel {
  final String firstName, image, email, phoneNumber;
  final List<ChatMessageModel> messages;

  ChatModel(
    super.id,
    this.firstName,
    this.image,
    this.email,
    this.phoneNumber,
      this.messages
  );

  static ChatModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String firstName = decoder.getString('first_name');
    String email = decoder.getString('email');
    String phoneNumber = decoder.getString('phone_number');
    String image = Images.randomImage(Images.avatars);

    List<dynamic>? messagesList = decoder.getObjectListOrNull('messages');
    List<ChatMessageModel> messages = [];
    if(messagesList!=null){
      messages = ChatMessageModel.listFromJSON(messagesList);
    }

    return ChatModel(decoder.getId, firstName,  image, email, phoneNumber, messages);
  }

  static List<ChatModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => ChatModel.fromJSON(e)).toList();
  }

  static List<ChatModel>? _dummyList;

  static Future<List<ChatModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/chat_data.json');
  }
}

class ChatMessageModel extends IdentifierModel {
  final String message;
  final DateTime sendAt;
  final bool fromMe;


  ChatMessageModel(
      super.id,
      this.message,
      this.sendAt, this.fromMe);

  static ChatMessageModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String message = decoder.getString('message');
    DateTime sendAt = decoder.getDateTime('send_at');
    bool fromMe = decoder.getBool('from_me');

    return ChatMessageModel(decoder.getId, message, sendAt,fromMe);
  }

  static List<ChatMessageModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => ChatMessageModel.fromJSON(e)).toList();
  }
}
