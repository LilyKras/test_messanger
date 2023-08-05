import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/domain/models/frase.dart';

class DialogController extends StateNotifier<DialogModel> {
  DialogController() : super(dialogs[0]);

  String getCompanionId() {
    return state.companionId;
  }

  void openDialog(DialogModel dialog) {
    DialogModel temp = DialogModel(
      isOpen: dialog.isOpen,
      companionName: dialog.companionName,
      dialog: dialog.dialog,
      companionId: dialog.companionId,
      imageUrl: dialog.imageUrl,
      marks: dialog.marks,
      messangerUrl: dialog.messangerUrl,
      licence: dialog.licence,
      unread: dialog.unread,
    );
    state = temp;
  }

  void changeOpenStatus() {
    DialogModel temp = DialogModel(
      isOpen: !state.isOpen,
      companionName: state.companionName,
      dialog: state.dialog,
      companionId: state.companionId,
      imageUrl: state.imageUrl,
      marks: state.marks,
      messangerUrl: state.messangerUrl,
      licence: state.licence,
    );

    state = temp;
  }

  void update(List<DialogModel> tempList) {
    for (var elem in tempList) {
      if (elem.companionId == state.companionId) {
        DialogModel temp = DialogModel(
          isOpen: elem.isOpen,
          companionName: elem.companionName,
          dialog: elem.dialog,
          companionId: elem.companionId,
          imageUrl: elem.imageUrl,
          marks: elem.marks,
          messangerUrl: elem.messangerUrl,
          licence: elem.licence,
        );
        state = temp;
        break;
      }
    }
  }

  String addNewFrase(FraseModel frase) {
    List dialog = jsonDecode(state.dialog);
    dialog.insert(0, {
      "isMe": frase.isMe,
      "text": frase.text,
      "time": frase.time,
    });

    String tempDialog = jsonEncode(dialog);

    DialogModel temp = DialogModel(
      isOpen: state.isOpen,
      companionName: state.companionName,
      dialog: tempDialog,
      companionId: state.companionId,
      imageUrl: state.imageUrl,
      marks: state.marks,
      messangerUrl: state.messangerUrl,
      licence: state.licence,
    );

    state = temp;

    return tempDialog;
  }
}

final dialogController = StateNotifierProvider((ref) {
  return DialogController();
});
