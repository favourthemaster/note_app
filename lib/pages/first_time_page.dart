import 'package:flutter/material.dart';
import 'package:noted/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimePage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  FirstTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  textAlign: TextAlign.center,
                  "Welcome\nIt looks like this is your first time opening the app\nWhat should I call you?"),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _textEditingController,
                decoration:
                    const InputDecoration(hintText: "Type in a username"),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  setUserName(_textEditingController.text);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(
                      userName: _textEditingController.text,
                    ),
                  ));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> setUserName(String userName) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('username', userName);
}
