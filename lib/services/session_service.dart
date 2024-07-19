import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/data/session_create_request.dart';

class SessionService {
  ApiService apiService = ApiService();

  Future<ApiResponse<Null>> create({
    required int eventId,
    required int roomId,
    required int price,
    required DateTime startsAt,
  }) async {
    SessionCreateRequest body = SessionCreateRequest(
      roomId: roomId,
      price: price,
      startsAt: startsAt,
    );

    return apiService.post(
      "events/$eventId/sessions",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> delete({
    required int eventId,
    required int sessionId,
  }) async {
    return apiService.delete(
      "events/$eventId/sessions/$sessionId",
      (_) => null,
    );
  }
}
