import 'package:flutter/material.dart';
import 'package:messenger/domain/models/dialog.dart';

class CompanionInfo extends StatelessWidget {
  const CompanionInfo({super.key, required this.dialog});
  final DialogModel? dialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.66 / 3.5,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(232, 236, 243, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                dialog!.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dialog!.companionName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Licence:${dialog!.licence}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
