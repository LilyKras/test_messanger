import 'package:messenger/domain/models/mark.dart';

class DialogModel {
  DialogModel({
    required this.isOpen,
    required this.companionName,
    required this.dialog,
    required this.companionId,
    required this.imageUrl,
    required this.marks,
    required this.messangerUrl,
    required this.licence,
  });
  final bool isOpen;
  final String companionName;
  final String companionId;
  final String dialog;
  final String imageUrl;
  final String messangerUrl;
  final List<Mark> marks;
  final int licence;
}
