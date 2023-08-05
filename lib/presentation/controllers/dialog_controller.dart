import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/domain/models/dialog.dart';

class DialogController extends StateNotifier<DialogModel?> {
  DialogController() : super(null);

  void openDialog(DialogModel dialog) {
    state = dialog;
  }

  void changeOpenStatus(List<DialogModel> dia) {
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
    for (int i = 0; i < dia.length; i++) {
      if (dia[i].companionId == state!.companionId) {
        dia[i] = temp;
      }
    }

    state = temp;
  }
}

final dialogController = StateNotifierProvider((ref) {
  return DialogController();
});
