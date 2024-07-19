import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/data/cinema_details_response.dart';
import 'package:cinema_booker/data/cinema_edit_request.dart';
import 'package:cinema_booker/data/cinema_list_response.dart';
import 'package:cinema_booker/data/cinema_create_request.dart';

class CinemaService {
  ApiService apiService = ApiService();

  Future<ApiResponse<List<CinemaListItem>>> list({
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

  Future<ApiResponse<CinemaDetailsResponse>> details({
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

  Future<ApiResponse<Null>> create({
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

  Future<ApiResponse<Null>> edit({
    required int cinemaId,
    required String name,
    required String description,
  }) async {
    CinemaEditRequest body = CinemaEditRequest(
      name: name,
      description: description,
    );

    return apiService.patch(
      "cinemas/$cinemaId",
      body.toJson(),
      (_) => null,
    );
  }
}
