import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/presentation/bloc/dialog_bloc.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/prewiew_dialog.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/profile_image.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({super.key, required this.dialog});

  final DialogModel dialog;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogBloc, DialogModel>(
      builder: (context, state) => GestureDetector(
        onTap: () {
          BlocProvider.of<DialogBloc>(context).add(OpenDialog(dialog));
        },
        child: Container(
          color: !(dialog.companionId == state.companionId)
              ? Colors.white
              : const Color(0xFFE8ECF3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileImage(
                      imageUrl: dialog.imageUrl,
                      messangerUrl: dialog.messangerUrl,
                    ),
                    PreviewDialog(
                      name: dialog.companionName,
                      text: dialog.isOpen
                          ? ((jsonDecode(dialog.dialog).first)['isMe']
                              ? 'me: ${(jsonDecode(dialog.dialog).first)['text']}'
                              : (jsonDecode(dialog.dialog).first)['text'])
                          : "Диалог закрыт",
                      marks: dialog.marks,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 * 0.1,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Flex(
                      mainAxisAlignment: MainAxisAlignment.end,
                      direction: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                DateFormat("HH:mm").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    (jsonDecode(dialog.dialog).first)['time'],
                                  ),
                                ),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            if (dialog.unread != 0)
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(232, 236, 243, 1),
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                padding: const EdgeInsets.all(3),
                                child: Text(dialog.unread.toString()),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
