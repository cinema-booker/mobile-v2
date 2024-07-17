import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/features/cinema/data/room_create_request.dart';

class RoomService {
  ApiService apiService = ApiService();

  Future<ApiResponse<Null>> createV2({
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

  Future<ApiResponse<Null>> deleteV2({
    required int cinemaId,
    required int roomId,
  }) async {
    return apiService.delete(
      "cinemas/$cinemaId/rooms/$roomId",
      (_) => null,
    );
  }

  // void create({
  //   required BuildContext context,
  //   required int cinemaId,
  //   required String number,
  //   required String type,
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     RoomCreateRequest body = RoomCreateRequest(
  //       number: number,
  //       type: type,
  //     );

  //     http.Response response = await http.post(
  //       Uri.parse('http://10.0.2.2:3000/cinemas/$cinemaId/rooms'),
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
  //           message: 'Room created successfully',
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
  //   required int cinemaId,
  //   required int roomId,
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.delete(
  //       Uri.parse('http://10.0.2.2:3000/cinemas/$cinemaId/rooms/$roomId'),
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
  //           message: 'Room deleted successfully',
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
