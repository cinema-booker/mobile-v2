
import 'package:cinema_booker/features/notification/notification_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {

  WebSocketChannel? _channel;

  void connectWebSocket(int managerID) {
    final url = 'ws://10.0.2.2:3000/ws?managerID=$managerID';
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(url),
      );

      print('WebSocket connection established');

      _channel!.stream.listen(
            (message) {
          print('Received from server: $message');
          NotificationService.showNotification(
            title: 'New Booking Notification',
            body: message,
          );
        },
        onDone: () {
          print('WebSocket connection closed');
        },
        onError: (error) {
          print('WebSocket error: ${error.toString()}');
        },
        cancelOnError: true,
      );
    } catch (e) {
      print('Failed to connect to WebSocket: ${e.toString()}');
    }
  }


  void dispose() {
    _channel?.sink.close();
    print('WebSocket connection closed by client');
  }
}