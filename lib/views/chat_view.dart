import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static String id = "ChatPage";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final controllerList = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();

  String? message;

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreateAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageModel = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageModel.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: KPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/scholar.png",
                      height: 70,
                    ),
                    const Text(
                      "chat",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: controllerList,
                          itemCount: messageModel.length,
                          itemBuilder: (context, index) {
                            return messageModel[index].id == email
                                ? ChatBubble(
                                    text: messageModel[index],
                                  )
                                : ChatBubbleFriend(
                                    text: messageModel[index],
                                  );
                          })),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        message = value;
                      },
                      onSubmitted: (data) {
                        messages.add({
                          "message": data,
                          KCreateAt: DateTime.now(),
                          'id': email
                        });

                        controller.clear();
                        controllerList.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration(
                        hintText: "Send Message",
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (message != null) {
                              messages.add({
                                "message": message,
                                KCreateAt: DateTime.now(),
                                'id': email
                              });
                            }

                            controller.clear();
                            controllerList.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: KPrimaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: KPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(body: Center(child: Text("loading...")));
          }
        });
  }
}
