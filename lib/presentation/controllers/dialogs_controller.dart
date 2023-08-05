import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/presentation/controllers/dialog_controller.dart';

class DialogsController extends StateNotifier<List<DialogModel>> {
  DialogsController() : super(dialogs);

  List<DialogModel> changeOpenStatus(String companionId) {
    int tempIndex = 0;
    for (int i = 0; i < state.length; i++) {
      if (state[i].companionId == companionId) {
        tempIndex = i;
      }
    }

    DialogModel? temp = DialogModel(
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
    return tempList;
  }
}

final dialogsController = StateNotifierProvider((ref) {
  return DialogController();
});

class DialogsManager {
  final DialogsController _allDialogsNotifier;
  final DialogController _dialogNotifier;

  const DialogsManager(
    this._allDialogsNotifier,
    this._dialogNotifier,
  );

  void changeOpenStatus(String companionId) {
    List<DialogModel> temp = _allDialogsNotifier.changeOpenStatus(companionId);
    _dialogNotifier.changeOpenStatus(temp);
  }
}

final dialogsProv = Provider((ref) {
  return DialogsManager(
    ref.watch(
      dialogsController.notifier
          as AlwaysAliveProviderListenable<DialogsController>,
    ),
    ref.watch(dialogController.notifier),
  );
});
