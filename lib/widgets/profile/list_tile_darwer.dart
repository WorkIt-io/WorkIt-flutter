import 'package:flutter/material.dart';

class ListTileDrawer extends StatelessWidget {
  const ListTileDrawer({super.key, required this.title, required this.leadingIconData, required this.trailingIconData, this.onTap});

  final String title;
  final IconData leadingIconData;
  final IconData trailingIconData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(                         
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(title, style: const TextStyle(fontSize: 22), ),
                leading: Icon(leadingIconData, size: 30,),
                trailing: Icon(trailingIconData, size: 40),
              ),
    );
  }
}