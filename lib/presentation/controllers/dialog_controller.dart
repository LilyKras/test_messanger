import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/domain/models/frase.dart';

class DialogController extends StateNotifier<DialogModel?> {
  DialogController() : super(null);

  void openDialog(DialogModel dialog) {
    state = dialog;
  }

  void changeOpenStatus() {
    DialogModel? temp = DialogModel(
      isOpen: !state!.isOpen,
      companionName: state!.companionName,
      dialog: state!.dialog,
      companionId: state!.companionId,
      imageUrl: state!.imageUrl,
      marks: state!.marks,
      messangerUrl: state!.messangerUrl,
      licence: state!.licence,
    );

    state = temp;
  }

  void update(List<DialogModel> temp) {
    if (state != null) {
      for (var elem in temp) {
        if (elem.companionId == state!.companionId) {
          state = elem;
          break;
        }
      }
    }
  }

  String addNewFrase(FraseModel frase) {
    List dialog = jsonDecode(state!.dialog);
    dialog.insert(0, {
      "isMe": frase.isMe,
      "text": frase.text,
      "time": frase.time,
    });

    String tempDialog = jsonEncode(dialog);

    DialogModel? temp = DialogModel(
      isOpen: state!.isOpen,
      companionName: state!.companionName,
      dialog: tempDialog,
      companionId: state!.companionId,
      imageUrl: state!.imageUrl,
      marks: state!.marks,
      messangerUrl: state!.messangerUrl,
      licence: state!.licence,
    );

    state = temp;

    return tempDialog;
  }
}

final dialogController = StateNotifierProvider((ref) {
  return DialogController();
});
