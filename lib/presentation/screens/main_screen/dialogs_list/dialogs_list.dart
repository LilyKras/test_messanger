import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/dialog_item.dart';

class DialogList extends StatelessWidget {
  const DialogList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.34,
      child: ListView.builder(
        itemCount: dialogs.length,
        itemBuilder: (context, index) => Consumer(
          builder: (context, ref, child) => DialogItem(
            dialog: dialogs[index],
          ),
        ),
      ),
    );
  }
}
