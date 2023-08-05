import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger/domain/models/frase.dart';

class FraseElement extends StatelessWidget {
  const FraseElement({super.key, required this.frase});

  final FraseModel frase;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            frase.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.66 * 0.4,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: frase.isMe
                  ? const Color.fromRGBO(180, 228, 255, 0.7)
                  : const Color.fromRGBO(0, 0, 0, 0.3),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: frase.isMe
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
                bottomRight: !frase.isMe
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
              ),
            ),
            child: Column(
              children: [
                Flex(
                  mainAxisAlignment: MainAxisAlignment.start,
                  direction: Axis.horizontal,
                  children: [Flexible(child: Text(frase.text))],
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.end,
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(frase.time),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
