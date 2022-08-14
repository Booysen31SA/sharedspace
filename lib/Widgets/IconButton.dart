import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final color;
  final IconData icon;
  final double size;
  const IconButtonCustom({
    Key? key,
    required this.color,
    required this.icon,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size,
      ),
    );
  }
}
