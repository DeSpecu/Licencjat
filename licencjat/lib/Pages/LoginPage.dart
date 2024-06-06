import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<LoginPage> {
  bool isMember = true;
  final email = TextEditingController();
  final password = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _changeType() {
    setState(() {
      isMember = !isMember;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Wpisz poprawny e-mail'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hasło',
                            hintText: 'Wpisz SILNE hasło'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: FilledButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 36, 33))),
                        child: isMember
                            ? const Text("Zaloguj się")
                            : const Text("Zarejestruj się"),
                        onPressed: () async {
                          if (isMember) {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          } else {
                            try {
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print('The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      ),
                    ),
                    if (isMember)
                      (Padding(
                        padding: EdgeInsets.all(30),
                        child: OutlinedButton(
                          style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 36, 33))),
                          child: Text("Nie masz konta? Zarejstruj się"),
                          onPressed: () {
                            _changeType();
                          },
                        ),
                      ))
                    else
                      (Padding(
                        padding: EdgeInsets.all(30),
                        child: OutlinedButton(
                          style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 36, 33))),
                          child: Text("Masz konto? zaloguj się"),
                          onPressed: () {
                            _changeType();
                          },
                        ),
                      )),
                  ],
                ))
          ]),
    );
  }
}