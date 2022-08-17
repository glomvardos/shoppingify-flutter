import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTapHandler,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function onTapHandler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(
          icon,
          size: 27,
          color: Colors.black,
        ),
        title: Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
      onTap: () => onTapHandler(),
    );
  }
}
