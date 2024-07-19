import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/data/room_create_request.dart';

class RoomService {
  ApiService apiService = ApiService();

  Future<ApiResponse<Null>> create({
    required int cinemaId,
    required String number,
    required String type,
  }) async {
    RoomCreateRequest body = RoomCreateRequest(
      number: number,
      type: type,
    );

    return apiService.post(
      "cinemas/$cinemaId/rooms",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> delete({
    required int cinemaId,
    required int roomId,
  }) async {
    return apiService.delete(
      "cinemas/$cinemaId/rooms/$roomId",
      (_) => null,
    );
  }
}
