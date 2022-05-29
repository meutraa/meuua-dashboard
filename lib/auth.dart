import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api.dart';
import 'main.dart';

void logout() {
  accessToken.val = null;
  profile.val = null;
}

void login(BuildContext context) {
  launchUrl(
    Uri(
      scheme: 'https',
      host: 'id.twitch.tv',
      pathSegments: <String>['oauth2', 'authorize'],
      queryParameters: <String, dynamic>{
        'response_type': 'token',
        'client_id': clientId,
        'redirect_uri': 'https://oauth.meuua.com',
        'scope': 'viewing_activity_read',
      },
    ),
  );

  final TextEditingController _tokenController = TextEditingController();
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Paste the access token from the URL'),
      content: TextField(
        controller: _tokenController,
        decoration: const InputDecoration(
          hintText: 'Access token',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            RestClient(Dio())
                .getProfile('Bearer ${_tokenController.text}', clientId)
                .then(
              (res) {
                accessToken.val = _tokenController.text;
                profile.val = res.data?.first;
              },
            );
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
