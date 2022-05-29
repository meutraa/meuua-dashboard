import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;

  const DrawerItem({
    required this.title,
    required this.leading,
    required this.selected,
    required this.onTap,
    super.key,
  });

  /*@override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: selected ? Colors.deepOrange.shade100 : Colors.transparent,
          ),
          child: ListTile(
            selected: selected,
            onTap: onTap,
            title: Text(title),
            leading: leading,
          ),
        ),
      );*/

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListTile(
          selected: selected,
          shape: StadiumBorder(
            side: BorderSide(
              color: selected
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Colors.transparent,
            ),
          ),
          selectedTileColor: Colors.deepOrange.shade100,
          onTap: onTap,
          title: Text(title),
          leading: leading,
        ),
      );
}
