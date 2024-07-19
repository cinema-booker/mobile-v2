
import 'package:cinema_booker/api/api_constants.dart';
import 'package:cinema_booker/services/notification_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {

  WebSocketChannel? _channel;

  void connectWebSocket(int managerID) {
    final url = 'ws://${ApiConstants.apiBaseUrl}/ws?managerID=$managerID';
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
          _reconnectWebSocket(managerID);
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

  void _reconnectWebSocket(int managerID) {
      print('Attempting to reconnect to WebSocket...');
      connectWebSocket(managerID);
  }


  void dispose() {
    _channel?.sink.close();
    print('WebSocket connection closed by client');
  }
}