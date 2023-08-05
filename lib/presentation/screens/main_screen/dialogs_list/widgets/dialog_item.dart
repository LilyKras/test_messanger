import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/presentation/controllers/dialog_controller.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/prewiew_dialog.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/profile_image.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({super.key, required this.dialog});

  final DialogModel dialog;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => GestureDetector(
        onTap: () {
          ref.watch(dialogController.notifier).openDialog(dialog);
        },
        child: Container(
          color: !(dialog == ref.watch(dialogController))
              ? Colors.white
              : const Color(0xFFE8ECF3),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImage(
                  imageUrl: dialog.imageUrl,
                  messangerUrl: dialog.messangerUrl,
                ),
                PreviewDialog(
                  name: dialog.companionName,
                  text: (jsonDecode(dialog.dialog).first)['isMe']
                      ? 'me: ${(jsonDecode(dialog.dialog).first)['text']}'
                      : (jsonDecode(dialog.dialog).first)['text'],
                  marks: dialog.marks,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
