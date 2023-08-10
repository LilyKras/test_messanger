import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/domain/models/dialog.dart';

class DialogBloc extends Bloc<DialogEvent, DialogModel> {
  DialogBloc() : super(dialogs[0]) {
    on<OpenDialog>(_onOpenDialog);
    on<ChangeOpenStatus>(_onChangeOpenStatus);
    on<Update>(_onUpdate);
    on<AddNewFrase>(_onAddNewFrase);
  }

  void _onOpenDialog(OpenDialog event, Emitter<DialogModel> emit) {
    DialogModel temp = DialogModel(
      isOpen: event.dialog.isOpen,
      companionName: event.dialog.companionName,
      dialog: event.dialog.dialog,
      companionId: event.dialog.companionId,
      imageUrl: event.dialog.imageUrl,
      marks: event.dialog.marks,
      messangerUrl: event.dialog.messangerUrl,
      licence: event.dialog.licence,
      unread: event.dialog.unread,
    );
    emit(temp);
  }

  void _onChangeOpenStatus(ChangeOpenStatus event, Emitter<DialogModel> emit) {
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

    emit(temp);
  }

  void _onUpdate(Update event, Emitter<DialogModel> emit) {
    for (var elem in event.tempList) {
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
        emit(temp);
        break;
      }
    }
  }

  void _onAddNewFrase(AddNewFrase event, Emitter<DialogModel> emit) {
    DialogModel temp = DialogModel(
      isOpen: state.isOpen,
      companionName: state.companionName,
      dialog: event.tempDialog,
      companionId: state.companionId,
      imageUrl: state.imageUrl,
      marks: state.marks,
      messangerUrl: state.messangerUrl,
      licence: state.licence,
    );

    emit(temp);
  }
}

abstract class DialogEvent {}

class OpenDialog extends DialogEvent {
  final DialogModel dialog;
  OpenDialog(this.dialog);
}

class ChangeOpenStatus extends DialogEvent {}

class Update extends DialogEvent {
  final List<DialogModel> tempList;
  Update(this.tempList);
}

class AddNewFrase extends DialogEvent {
  final String tempDialog;
  AddNewFrase(this.tempDialog);
}
