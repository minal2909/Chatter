import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageBubble(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24,
          right: isSendByMe ? 24 : 0,
          top: 10,
          bottom: 10,
        ),
        width: MediaQuery.of(context).size.width,
        alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isSendByMe
                ? kSecondaryColor.withOpacity(0.5)
                : kPrimaryColor.withOpacity(0.9),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              message,
              style: TextStyle(
                  color: isSendByMe ? Colors.black : Colors.white,
                  fontSize: 17),
            ),
          ),
        ));
  }
}
