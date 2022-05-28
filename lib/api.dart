import 'package:dio/dio.dart';
import 'package:meuua/model/channel_settings.dart';
import 'package:meuua/model/twitch_user_response.dart';
import 'package:retrofit/retrofit.dart';

import 'model/command.dart';
import 'model/user.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://api.meuua.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/channels")
  Future<List<User>> getChannels();

  @GET("/channels/{id}")
  Future<ChannelSettings> getChannelSettings(@Path("id") String channelId);

  @PATCH("/channels/{id}")
  Future<ChannelSettings> patchChannelSettings({
    @Path("id") required String channelId,
    @Header("Authorization") required String authorization,
    @Body() required ChannelSettings settings,
  });

  @GET("/commands")
  Future<List<Command>> getGlobalCommands();

  @GET("https://api.twitch.tv/helix/users")
  Future<TwitchUserResponse> getProfile(
    @Header("Authorization") String accessToken,
    @Header("Client-Id") String clientId,
  );
}
