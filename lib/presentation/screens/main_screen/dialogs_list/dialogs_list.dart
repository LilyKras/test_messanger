import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/domain/models/dialog.dart';
import 'package:messenger/presentation/controllers/dialogs_controller.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/dialog_item.dart';

class DialogList extends StatelessWidget {
  const DialogList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.34,
      child: ListView.builder(
        itemCount: dialogs.length,
        itemBuilder: (context, index) => Consumer(
          builder: (context, ref, child) => DialogItem(
            dialog: (ref.watch(dialogsController) as List<DialogModel>)[index],
          ),
        ),
      ),
    );
  }
}
