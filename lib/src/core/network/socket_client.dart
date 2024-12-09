import 'dart:developer';

import 'package:ai_translator/src/core/network/event.dart';
import 'package:ai_translator/src/core/network/stream_socket.dart';
import 'package:ai_translator/src/services/app/token.dart';
import "package:socket_io_client/socket_io_client.dart" as client;

class SocketClient {
  final UserStateRepo tokenRepository;
  String baseUrl = '';
  SocketClient({required this.tokenRepository});
  client.Socket? socket;
  void init() {
    log("in init");
    final token = tokenRepository.getToken().token;
    socket = client.io(
        baseUrl,
        client.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'authorization': 'Bearer $token'})
            .build());

    socket?.connect();
    socket?.onConnect((_) {
      log("socket connected");
    });
    socket?.onDisconnect((_) {
      log('socket disconnected');
    });
    socket?.onError((n) {
      log("socket error");
    });
  }

  void disconnectSocket() {
    log('in disconnect');
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }

  StreamSocket<T> connectAndListen<T>(String event) {
    if (socket == null) {
      init();
    }
    log('in connect and listen, $event');
    final streamSocket = StreamSocket<T>();

    return streamSocket;
  }

  void emit(Event event) {
    if (socket == null) {
      init();
    }
    log("in emit");
    log('${event.name}, ${event.data()}');
    socket?.emit(event.name, event.data());
  }
}
