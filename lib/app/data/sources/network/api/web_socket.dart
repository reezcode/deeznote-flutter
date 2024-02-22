// ignore_for_file: avoid_print, library_prefixes

import 'package:socket_io_client/socket_io_client.dart' as IO;

/// RsSocket is a class to handle socket connection
/// RsSocket using IO Web Socket
class RsSocket {
  static final RsSocket _instance = RsSocket._internal();
  factory RsSocket() {
    return _instance;
  }
  RsSocket._internal();
  IO.Socket? _socket;

  void connect(
      {required String uri,
      Map<String, dynamic>? query,
      Map<String, dynamic>? extraOptions}) {
    _socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'query': query,
      ...extraOptions!
    });
    _socket!.connect();
    _socket!.onConnect((data) => print("Socket Connected"));
  }

  void disconnect() {
    _socket!.disconnect();
  }

  void emit(String event, Map<String, dynamic> data) {
    _socket!.emit(event, data);
  }

  void on(String event, Function callback) {
    _socket!.on(event, (data) => callback(data));
  }
}
