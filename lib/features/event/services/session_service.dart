import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/features/event/data/session_create_request.dart';

class SessionService {
  ApiService apiService = ApiService();

  Future<ApiResponse<Null>> createV2({
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

  Future<ApiResponse<Null>> deleteV2({
    required int eventId,
    required int sessionId,
  }) async {
    return apiService.delete(
      "events/$eventId/sessions/$sessionId",
      (_) => null,
    );
  }

  // void create({
  //   required BuildContext context,
  //   required int eventId,
  //   required int roomId,
  //   required int price,
  //   required DateTime startsAt,
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     SessionCreateRequest body = SessionCreateRequest(
  //       roomId: roomId,
  //       price: price,
  //       startsAt: startsAt,
  //     );

  //     http.Response response = await http.post(
  //       Uri.parse('http://10.0.2.2:3000/events/$eventId/sessions'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: body.toJson(),
  //     );

  //     httpErrorHandler(
  //       response: response,
  //       context: context,
  //       onSuccess: () {
  //         showSnackBarError(
  //           context: context,
  //           message: 'Session created successfully',
  //         );

  //         context.pop();
  //       },
  //     );
  //   } catch (error) {
  //     showSnackBarError(
  //       context: context,
  //       message: error.toString(),
  //     );
  //   }
  // }

  // void delete({
  //   required BuildContext context,
  //   required int eventId,
  //   required int sessionId,
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.delete(
  //       Uri.parse('http://10.0.2.2:3000/events/$eventId/sessions/$sessionId'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     httpErrorHandler(
  //       response: response,
  //       context: context,
  //       onSuccess: () {
  //         showSnackBarError(
  //           context: context,
  //           message: 'Session deleted successfully',
  //         );
  //       },
  //     );
  //   } catch (error) {
  //     showSnackBarError(
  //       context: context,
  //       message: error.toString(),
  //     );
  //   }
  // }
}
