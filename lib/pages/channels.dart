import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../avatar.dart';
import '../main.dart';
import '../mixin_value_notifier.dart';
import '../model/user.dart';

class ChannelsPage extends StatefulWidget {
  final Function(User user) onUserSelected;
  final Function(bool) onUserRegistered;
  final ValueNotifier<int> registerNotifier;

  const ChannelsPage({
    required this.registerNotifier,
    required this.onUserSelected,
    required this.onUserRegistered,
    super.key,
  });

  @override
  State<ChannelsPage> createState() => ChannelsPageState();
}

class ChannelsPageState extends State<ChannelsPage>
    with
        AutomaticKeepAliveClientMixin,
        ValueNotifierMixin<ChannelsPage, User?> {
  List<User>? _users;

  @override
  ValueNotifier<User?> get notifier => profile.notifier;

  @override
  bool get wantKeepAlive => _users != null;

  @override
  void initState() {
    super.initState();
    RestClient(Dio()).getChannels().then((List<User> users) {
      if (!mounted) {
        return;
      }

      users = modifyUsers(users);

      setState(() => _users = users);
    });

    widget.registerNotifier.addListener(onRegister);
  }

  @override
  void onChange() {
    super.onChange();
    setState(() => _users = modifyUsers(_users));
  }

  List<User> modifyUsers(List<User>? users) {
    if (users == null) {
      return [];
    }
    if (value != null) {
      try {
        final user = users.firstWhere((user) => user.id == value!.id);
        // put the user matching profile.val first in the list of users
        users
          ..remove(user)
          ..insert(0, user);
        widget.onUserRegistered(true);
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        widget.onUserRegistered(false);
      }
    }

    return users;
  }

  void onRegister() {
    if (_users == null) {
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _users?.insert(0, value!);
    });
  }

  @override
  void dispose() {
    widget.registerNotifier.removeListener(onRegister);
    super.dispose();
  }

  Future<void> leave() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave channel'),
        content:
            const Text('Are you sure you want Meuua to leave your channel?\n\n'
                'This will delete channel settings, '
                'but retain commands and approvals.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Leave'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == null || !confirmed) {
      return;
    }

    // ignore: unawaited_futures
    RestClient(Dio())
        .unregister(channelId: value!.id, authorization: accessToken.val!)
        .then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        widget.onUserRegistered(false);
        _users?.removeAt(0);
      });
    }).catchError((dynamic obj) {
      if (obj is DioError) {
        final data = obj.response?.data as String?;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            data ??
                obj.response?.statusMessage?.toString() ??
                'An error occurred',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _users?.length ?? 0,
      separatorBuilder: (context, index) {
        final isSelf = index == 0 && _users![index].id == value?.id;
        return isSelf
            ? const Divider(
                indent: 32,
                endIndent: 32,
              )
            : const SizedBox.shrink();
      },
      itemBuilder: (context, index) {
        final isSelf = index == 0 && _users![index].id == value?.id;
        return _users == null
            ? const Center(child: CircularProgressIndicator())
            : ListTile(
                key: ValueKey(_users![index].id),
                onTap: () => widget.onUserSelected(_users![index]),
                leading: Avatar(
                  url: _users![index].profileImageUrl,
                  border: isSelf,
                  size: 48,
                ),
                isThreeLine: isSelf,
                title: isSelf
                    ? Text(
                        _users![index].displayName,
                        maxLines: 3,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _users![index].displayName,
                            maxLines: 3,
                          ),
                          Text(
                            '${_users![index].viewCount} views',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                subtitle: Text(
                  _users![index].description,
                  maxLines: 3,
                ),
                trailing: isSelf
                    ? ElevatedButton.icon(
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Leave'),
                        onPressed: leave,
                      )
                    : null,
              );
      },
    );
  }
}
