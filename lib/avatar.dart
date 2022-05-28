import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? url;
  final double size;

  const Avatar({
    super.key,
    required this.url,
    required this.size,
  });

  @override
  Widget build(BuildContext context) => Card(
        shape: const CircleBorder(),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        child: Builder(builder: (context) {
          if (url == null || url!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
