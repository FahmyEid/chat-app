// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_container.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class ResgisterView extends StatefulWidget {
  static String id = "ResgisterPage";

  // ignore: prefer_const_constructors_in_immutables
  ResgisterView({
    super.key,
  });

  @override
  State<ResgisterView> createState() => _ResgisterViewState();
}

class _ResgisterViewState extends State<ResgisterView> {
  String? password;

  String? email;

  GlobalKey<FormState> fromKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: fromKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("assets/images/scholar.png"),
              const Text(
                "Scholar Chat",
                style: TextStyle(
                    fontSize: 32, color: Colors.white, fontFamily: "Pacifico"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Resgister",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              CustomTextformField(
                onChanged: (data) {
                  email = data;
                },
                label: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              CustomTextformField(
                onChanged: (data) {
                  password = data;
                },
                label: "password",
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              CustomContainer(
                onTap: () async {
                  if (fromKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await registerUser();
                      Navigator.pushNamed(context, ChatView.id,arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnakBar(context, 'weak-password');
                      } else if (e.code == 'email-already-in-use') {
                        showSnakBar(context,
                            'The account already exists for that email.');
                      }
                    } catch (e) {
                      showSnakBar(context, 'there was an error');
                    }
                    isLoading = false;
                    setState(() {});
                  } else {}
                },
                text: "Resgister",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 130,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "don't have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
