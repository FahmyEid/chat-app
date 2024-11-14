
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatBubble extends StatelessWidget {
    ChatBubble({
    super.key,required this.text
  });
  MessageModel text;
  @override
  Widget build(BuildContext context) {
   
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(32),
            topStart: Radius.circular(32),
            bottomEnd: Radius.circular(32),
          ),
        ),
        margin:const  EdgeInsets.symmetric(horizontal:  16,vertical: 8),
    
        child: 
        
        Text(text.message,style:const TextStyle(color: Colors.white),),
      ),
    );
  }
}


// ignore: must_be_immutable
class ChatBubbleFriend extends StatelessWidget {
    ChatBubbleFriend({
    super.key,required this.text
  });
  MessageModel text;
  @override
  Widget build(BuildContext context) {
   
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(32),
            topStart: Radius.circular(32),
            bottomStart: Radius.circular(32),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal:  16,vertical: 8),
    
        child: 
        
        Text(text.message,style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
