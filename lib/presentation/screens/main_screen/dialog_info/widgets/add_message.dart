import 'dart:math';

import 'package:flutter/material.dart';

class AddMessageField extends StatelessWidget {
  AddMessageField({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: min(34, MediaQuery.of(context).size.width / 25),
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 1,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Начни писать что-нибудь...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35.0),
                      ),
                    ),
                  ),
                  controller: _controller,
                  onSubmitted: (String value) async {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thanks!'),
                          content: Text(
                            'You typed "$value", which has length ${value.characters.length}.',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.emoji_emotions_outlined,
                  size: min(34, MediaQuery.of(context).size.width / 25),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.mic_rounded,
              size: min(34, MediaQuery.of(context).size.width / 25),
            ),
          ),
        ],
      ),
    );
  }
}
