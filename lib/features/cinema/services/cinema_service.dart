import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/features/cinema/data/cinema_details_response.dart';
import 'package:cinema_booker/features/cinema/data/cinema_list_response.dart';
import 'package:cinema_booker/features/cinema/data/cinema_create_request.dart';

class CinemaService {
  ApiService apiService = ApiService();

  Future<ApiResponse<List<CinemaListItem>>> listV2({
    int page = 1,
    int limit = 10,
    String search = '',
  }) {
    return apiService.get<List<CinemaListItem>>(
      "cinemas",
      {
        'page': page.toString(),
        'limit': limit.toString(),
        'search': search,
      },
      (data) {
        CinemaListResponse cinemaListResponse =
            CinemaListResponse.fromJson(data);
        return cinemaListResponse.cinemas;
      },
    );
  }

  Future<ApiResponse<CinemaDetailsResponse>> detailsV2({
    required int cinemaId,
  }) async {
    return apiService.get<CinemaDetailsResponse>(
      "cinemas/$cinemaId",
      null,
      (data) {
        CinemaDetailsResponse cinemaDetailsResponse =
            CinemaDetailsResponse.fromJson(data);
        return cinemaDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> createV2({
    required String name,
    required String description,
    required String address,
    required double longitude,
    required double latitude,
  }) async {
    CinemaCreateRequest body = CinemaCreateRequest(
      name: name,
      description: description,
      address: address,
      longitude: longitude,
      latitude: latitude,
    );

    return apiService.post(
      "cinemas",
      body.toJson(),
      (_) => null,
    );
  }

  // Future<List<CinemaListItem>> list({
  //   required BuildContext context,
  //   int page = 1,
  //   int limit = 10,
  //   String search = '',
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.get(
  //       Uri.parse(
  //         'http://10.0.2.2:3000/cinemas?page=$page&limit=$limit&search=$search',
  //       ),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       CinemaListResponse cinemaListResponse =
  //           CinemaListResponse.fromJson(response.body);
  //       return cinemaListResponse.cinemas;
  //     } else {
  //       showSnackBarError(
  //         context: context,
  //         message: 'Failed to fetch cinema list',
  //       );
  //       return [];
  //     }
  //   } catch (error) {
  //     showSnackBarError(
  //       context: context,
  //       message: error.toString(),
  //     );
  //     return [];
  //   }
  // }

  // Future<CinemaDetailsResponse?> details({
  //   required BuildContext context,
  //   required int cinemaId,
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.get(
  //       Uri.parse('http://10.0.2.2:3000/cinemas/$cinemaId'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       CinemaDetailsResponse cinemaDetailsResponse =
  //           CinemaDetailsResponse.fromJson(response.body);
  //       return cinemaDetailsResponse;
  //     } else {
  //       showSnackBarError(
  //         context: context,
  //         message: 'Failed to fetch cinema list',
  //       );
  //       return null;
  //     }
  //   } catch (error) {
  //     showSnackBarError(
  //       context: context,
  //       message: error.toString(),
  //     );
  //     return null;
  //   }
  // }

  // void create({
  //   required BuildContext context,
  //   required String name,
  //   required String description,
  //   required String address,
  //   required double longitude,
  //   required double latitude,
  // }) async {
  //   try {
  //     CinemaCreateRequest body = CinemaCreateRequest(
  //       name: name,
  //       description: description,
  //       address: address,
  //       longitude: longitude,
  //       latitude: latitude,
  //     );

  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.post(
  //       Uri.parse('http://10.0.2.2:3000/cinemas'),
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
  //           message: 'Cinema created successfully',
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
