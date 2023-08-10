import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/data/dialogs.dart';
import 'package:messenger/presentation/bloc/dialogs_bloc.dart';
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
        itemBuilder: (context, index) => Builder(
          builder: (ctx) {
            return DialogItem(
              dialog: ctx.watch<DialogsBloc>().state[index],
            );
          },
        ),
      ),
    );
  }
}
