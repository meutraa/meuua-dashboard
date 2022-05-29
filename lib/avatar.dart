import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? url;
  final double size;
  final bool border;

  const Avatar({
    required this.url,
    required this.size,
    this.border = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
        shape: CircleBorder(
          side: BorderSide(
            color: border
                ? Theme.of(context).colorScheme.inversePrimary
                : Colors.transparent,
            width: 2,
          ),
        ),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        child: Builder(builder: (context) {
          if (url == null || url!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.person,
                color: Colors.grey,
                size: size,
              ),
            );
          }
          return Image.network(
            url!,
            height: size,
            isAntiAlias: true,
            width: size,
          );
        }),
      );
}
