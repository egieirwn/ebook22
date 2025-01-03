import 'package:flutter/material.dart';

class ProfileMenuItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const ProfileMenuItems({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? const Color.fromARGB(255, 66, 184, 230)),
      title: Text(
        title,
        style: TextStyle(color: color ?? Colors.black, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}
