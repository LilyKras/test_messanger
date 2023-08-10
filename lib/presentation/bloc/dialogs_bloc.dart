import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/domain/models/frase.dart';
import 'package:messenger/presentation/bloc/dialog_bloc.dart';

var _rng = Random();

class DialogsBloc extends Bloc<DialogsEvent, List<DialogModel>> {
  final DialogBloc dialogBloc;

  DialogsBloc(this.dialogBloc) : super(dialogs) {
    on<ChangeOpenStatuses>(_onChangeOpenStatuses);
    on<AddRandomFrases>(_onAddRandomFrases);
    on<AddNewFrases>(_onAddNewFrases);
  }

  void _onChangeOpenStatuses(
    ChangeOpenStatuses event,
    Emitter<List<DialogModel>> emit,
  ) {
    int tempIndex = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i].companionId == dialogBloc.state.companionId) {
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
    dialogBloc.add(ChangeOpenStatus());

    List<DialogModel> tempList = [];
    for (int i = 0; i < tempIndex; i++) {
      tempList.add(state[i]);
    }
    tempList.add(temp);
    for (int i = tempIndex + 1; i < state.length; i++) {
      tempList.add(state[i]);
    }

    emit(tempList);
  }

  void _onAddRandomFrases(
    AddRandomFrases event,
    Emitter<List<DialogModel>> emit,
  ) {
    String currCompanionId = dialogBloc.state.companionId;
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

    emit(temp);
    dialogBloc.add(Update(state));
  }

  void _onAddNewFrases(AddNewFrases event, Emitter<List<DialogModel>> emit) {
    String currCompanionId = dialogBloc.state.companionId;
    int tempIndex = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i].companionId == currCompanionId) {
        tempIndex = i;
        break;
      }
    }

    List dialog = jsonDecode(state[tempIndex].dialog);
    dialog.insert(0, {
      "isMe": event.frase.isMe,
      "text": event.frase.text,
      "time": event.frase.time,
    });
    String tempDialog = jsonEncode(dialog);

    dialogBloc.add(AddNewFrase(tempDialog));

    DialogModel temp = DialogModel(
      isOpen: state[tempIndex].isOpen,
      companionName: state[tempIndex].companionName,
      dialog: tempDialog,
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

    emit(tempList);
  }
}

abstract class DialogsEvent {}

class ChangeOpenStatuses extends DialogsEvent {
  ChangeOpenStatuses();
}

class AddRandomFrases extends DialogsEvent {
  AddRandomFrases();
}

class AddNewFrases extends DialogsEvent {
  final FraseModel frase;
  AddNewFrases(this.frase);
}
