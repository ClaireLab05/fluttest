// ignore: depend_on_referenced_packages
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:fluttest/models/text_message.dart';
import 'package:fluttest/widgets/message_widget.dart';

class TextMessageWidget extends MessageWidget {
  TextMessageWidget({
    key,
    required message,
  }) : super(key: key, message: message) {
    if (message is! TextMessage) {
      throw Exception("Le message doit être de type TextMessage");
    }
  }

  @override
  Widget getBody() {
    return Text((message as TextMessage).text);
  }
}
