import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/domain/models/frase.dart';
import 'package:messenger/presentation/bloc/dialog_bloc.dart';
import 'package:messenger/presentation/bloc/dialogs_bloc.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/widgets/add_message.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/widgets/companion_info.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/widgets/frase_element.dart';

class DialogInfo extends StatelessWidget {
  const DialogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogBloc, DialogModel>(
      builder: (context, state) {
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
                    height: MediaQuery.of(context).size.height - 88,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: jsonDecode(state.dialog).length + 1,
                      itemBuilder: (context, index) {
                        if (index != jsonDecode(state.dialog).length) {
                          FraseModel temp = FraseModel(
                            isMe: jsonDecode(state.dialog)[index]['isMe'],
                            text: jsonDecode(state.dialog)[index]['text'],
                            time: jsonDecode(state.dialog)[index]['time'],
                          );

                          if (index != jsonDecode(state.dialog).length - 1) {
                            DateTime date1 =
                                DateTime.fromMillisecondsSinceEpoch(
                              jsonDecode(state.dialog)[index]['time'],
                            );
                            DateTime date2 =
                                DateTime.fromMillisecondsSinceEpoch(
                              jsonDecode(state.dialog)[index + 1]['time'],
                            );
                            if (!(date1.year == date2.year &&
                                date1.month == date2.month &&
                                date1.day == date2.day)) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(23),
                                      border: Border.all(
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 0.11),
                                      ),
                                    ),
                                    child: Text(
                                      DateFormat('d LLL y').format(date1),
                                    ),
                                  ),
                                  FraseElement(frase: temp),
                                ],
                              );
                            }
                          }

                          return FraseElement(frase: temp);
                        } else {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                  border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 0.11),
                                  ),
                                ),
                                child: Text(
                                  DateFormat('d LLL y').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      jsonDecode(state.dialog).last['time'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
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
                          dialog: state,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              activeColor: Colors.white,
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.white,
                              value: state.isOpen,
                              onChanged: (_) {
                                BlocProvider.of<DialogsBloc>(context)
                                    .add(ChangeOpenStatuses());
                              },
                            ),
                            state.isOpen
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
              const AddMessageField()
            ],
          ),
        );
      },
    );
  }
}
