import 'package:flutter/material.dart';
import 'package:messenger/domain/models/mark.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/widgets/mark_item.dart';

class PreviewDialog extends StatelessWidget {
  const PreviewDialog({
    super.key,
    required this.name,
    this.marks = const [],
    required this.text,
  });
  final String name;
  final List<Mark> marks;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              overflow: TextOverflow.ellipsis,
            ),
            if (marks.isNotEmpty)
              Row(
                children: (marks.length <= 4)
                    ? [
                        ...(marks).map(
                          (e) => MarkItem(
                            color: e.color,
                            text: e.text,
                          ),
                        )
                      ]
                    : [
                        MarkItem(
                          color: marks[0].color,
                          text: marks[0].text,
                        ),
                        MarkItem(
                          color: marks[1].color,
                          text: marks[1].text,
                        ),
                        MarkItem(
                          color: marks[2].color,
                          text: marks[2].text,
                        ),
                      ],
              ),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
