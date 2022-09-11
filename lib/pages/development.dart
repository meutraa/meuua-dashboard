import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DevelopmentPage extends StatelessWidget {
  const DevelopmentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Theme.of(context).colorScheme.onBackground);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        // Add a richtext link to the source code here
        Text(
          'Source Code',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Divider(
          indent: 32,
          endIndent: 32,
          height: 24,
          color: Colors.white60,
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Dashboard\n\n',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextSpan(
                text: 'https://git.lost.host/meutraa/meuua-dashboard',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launchUrlString(
                        'https://git.lost.host/meutraa/meuua-dashboard',
                      ),
              ),
              TextSpan(
                text: '\n\nServer\n\n',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextSpan(
                text: 'https://git.lost.host/meutraa/meutraabot',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launchUrlString(
                        'https://git.lost.host/meutraa/meutraabot',
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Admin Dashboard Features',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Divider(
          indent: 32,
          endIndent: 32,
          height: 24,
          color: Colors.white60,
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Edit channel approvals',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Edit channel commands',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Join/leave channels',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Configure channel settings',
              style: style,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Dashboard Features',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Divider(
          indent: 32,
          endIndent: 32,
          height: 24,
          color: Colors.white60,
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'Twitch authentication',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Twitch authentication without copy+paste token',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'View channels',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'View channel settings',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'View global commands',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'View channel approvals',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Edit channel approvals',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'View channel commands',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Edit channel commands',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'Join/leave own channel',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'Configure own channel settings',
              style: style,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'Server Features',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Divider(
          indent: 32,
          endIndent: 32,
          height: 24,
          color: Colors.white60,
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Configure bot banning',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'Configure auto replies',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'Set OpenAI token',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Set OpenAI model',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: true, onChanged: null),
            Text(
              'Configure safety',
              style: style,
            ),
          ],
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            Text(
              'Use clasification to detect safety',
              style: style,
            ),
          ],
        ),
      ],
    );
  }
}
