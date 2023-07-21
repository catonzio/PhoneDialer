import 'package:flutter/material.dart';

class BottomBarIcon extends StatelessWidget {
  final Icon icon;
  final bool isActive;
  final Function() onPressed;

  const BottomBarIcon(
      {super.key,
      required this.icon,
      required this.isActive,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: icon,
          onPressed: onPressed,
          color: isActive ? Colors.purple : Colors.grey,
        ),
        Container(
          height: 2,
          width: 15,
          color: isActive ? Colors.purple : Colors.transparent,
        )
      ],
    );
  }
}
