import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/domain/models/frase.dart';
import 'package:messenger/presentation/controllers/dialog_controller.dart';
import 'package:messenger/presentation/controllers/dialogs_controller.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/widgets/add_message.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/widgets/companion_info.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/widgets/frase_element.dart';

class DialogInfo extends ConsumerWidget {
  const DialogInfo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    DialogModel? temp = ref.watch(dialogController) as DialogModel?;
    List<dynamic> frases = (temp != null) ? jsonDecode(temp.dialog) : [];

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.66 - 1,
                height: (temp != null)
                    ? MediaQuery.of(context).size.height - 88
                    : MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  reverse: true,
                  itemCount: frases.length + 1,
                  itemBuilder: (context, index) {
                    if (index != frases.length) {
                      FraseModel temp = FraseModel(
                        isMe: frases[index]['isMe'],
                        text: frases[index]['text'],
                        time: frases[index]['time'],
                      );
                      return FraseElement(frase: temp);
                    } else {
                      return const SizedBox(
                        height: 100,
                      );
                    }
                  },
                ),
              ),
              if (temp != null)
                Container(
                  height: 82,
                  width: MediaQuery.of(context).size.width * 0.66 - 1,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CompanionInfo(
                        dialog: temp,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Colors.white,
                            value: temp.isOpen,
                            onChanged: (_) {
                              ref
                                  .read(dialogsProv)
                                  .changeOpenStatus(temp.companionId);
                            },
                          ),
                          temp.isOpen
                              ? const Text(
                                  "Открыт",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                )
                              : const Text(
                                  "Закрыт",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          )
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ),
          if (temp != null) AddMessageField()
        ],
      ),
    );
  }
}
