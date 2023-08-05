import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/domain/models/frase.dart';
import 'package:messenger/presentation/controllers/dialog_controller.dart';

var _rng = Random();

class DialogsController extends StateNotifier<List<DialogModel>> {
  DialogsController() : super(dialogs);

  void changeOpenStatus(String companionId) {
    int tempIndex = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i].companionId == companionId) {
        tempIndex = i;
        break;
      }
    }

    DialogModel temp = DialogModel(
      isOpen: !state[tempIndex].isOpen,
      companionName: state[tempIndex].companionName,
      dialog: state[tempIndex].dialog,
      companionId: state[tempIndex].companionId,
      imageUrl: state[tempIndex].imageUrl,
      marks: state[tempIndex].marks,
      messangerUrl: state[tempIndex].messangerUrl,
      licence: state[tempIndex].licence,
    );
    List<DialogModel> tempList = [];
    for (int i = 0; i < tempIndex; i++) {
      tempList.add(state[i]);
    }
    tempList.add(temp);
    for (int i = tempIndex + 1; i < state.length; i++) {
      tempList.add(state[i]);
    }

    state = tempList;
  }

  List<DialogModel> addRandomFrase(String currCompanionId) {
    List<DialogModel> temp = [];

    for (var elem in state) {
      List dialog = jsonDecode(elem.dialog);
      int unread = elem.unread;
      if (elem.isOpen) {
        dialog.insert(0, {
          "isMe": _rng.nextBool(),
          "text": randomFrase[_rng.nextInt(randomFrase.length - 1)],
          "time": (DateTime.now()).millisecondsSinceEpoch,
        });
        if (!dialog[0]['isMe']) unread += 1;
      }

      String tempDialog = jsonEncode(dialog);
      DialogModel tempElem = DialogModel(
        isOpen: elem.isOpen,
        companionName: elem.companionName,
        dialog: tempDialog,
        companionId: elem.companionId,
        imageUrl: elem.imageUrl,
        marks: elem.marks,
        messangerUrl: elem.messangerUrl,
        licence: elem.licence,
        unread: (elem.companionId != currCompanionId) ? unread : 0,
      );

      temp.add(tempElem);
    }
    state = temp;
    return state;
  }

  void addNewFrase(String dialog, String companionId) {
    int tempIndex = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i].companionId == companionId) {
        tempIndex = i;
        break;
      }
    }

    DialogModel temp = DialogModel(
      isOpen: state[tempIndex].isOpen,
      companionName: state[tempIndex].companionName,
      dialog: dialog,
      companionId: state[tempIndex].companionId,
      imageUrl: state[tempIndex].imageUrl,
      marks: state[tempIndex].marks,
      messangerUrl: state[tempIndex].messangerUrl,
      licence: state[tempIndex].licence,
    );

    List<DialogModel> tempList = [];
    for (int i = 0; i < tempIndex; i++) {
      tempList.add(state[i]);
    }
    tempList.add(temp);
    for (int i = tempIndex + 1; i < state.length; i++) {
      tempList.add(state[i]);
    }

    state = tempList;
  }
}

final dialogsController = StateNotifierProvider((ref) {
  return DialogsController();
});

class DialogsManager {
  final DialogsController _allDialogsNotifier;
  final DialogController _dialogNotifier;

  const DialogsManager(
    this._allDialogsNotifier,
    this._dialogNotifier,
  );

  void changeOpenStatus(String companionId) {
    _allDialogsNotifier.changeOpenStatus(companionId);
    _dialogNotifier.changeOpenStatus();
  }

  void addNewFrase(String companionId, FraseModel frase) {
    String tempDialog = _dialogNotifier.addNewFrase(frase);
    _allDialogsNotifier.addNewFrase(tempDialog, companionId);
  }

  void addRandowFrase() {
    String currCompanionId = _dialogNotifier.getCompanionId();
    List<DialogModel> temp =
        _allDialogsNotifier.addRandomFrase(currCompanionId);
    _dialogNotifier.update(temp);
  }
}

final dialogsProv = Provider((ref) {
  return DialogsManager(
    ref.watch(dialogsController.notifier),
    ref.watch(dialogController.notifier),
  );
});
