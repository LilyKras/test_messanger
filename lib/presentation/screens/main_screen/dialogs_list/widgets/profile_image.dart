import 'dart:math';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
    required this.messangerUrl,
  });

  final String imageUrl;
  final String messangerUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: min(MediaQuery.of(context).size.width * 0.34 * 0.2, 61),
          width: min(MediaQuery.of(context).size.width * 0.34 * 0.2, 61),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height:
              min(MediaQuery.of(context).size.width * 0.34 * 0.2 * 0.42, 26),
          width: min(MediaQuery.of(context).size.width * 0.34 * 0.2 * 0.42, 26),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(500)),
          child: ClipOval(
            child: Image.network(
              messangerUrl,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
