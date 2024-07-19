import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/data/user_details_response.dart';
import 'package:cinema_booker/data/user_edit_password_request.dart';
import 'package:cinema_booker/data/user_edit_request.dart';
import 'package:cinema_booker/data/user_list_response.dart';

class UserService {
  ApiService apiService = ApiService();

  Future<ApiResponse<List<UserListItem>>> list({
    int page = 1,
    int limit = 10,
    String search = '',
  }) {
    return apiService.get<List<UserListItem>>(
      "users",
      {
        'page': page.toString(),
        'limit': limit.toString(),
        'search': search,
      },
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }

  Future<ApiResponse<UserDetailsResponse>> details({
    required int userId,
  }) async {
    return apiService.get<UserDetailsResponse>(
      "users/$userId",
      null,
      (data) {
        UserDetailsResponse userDetailsResponse =
            UserDetailsResponse.fromJson(data);
        return userDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> edit({
    required int userId,
    required String name,
  }) async {
    UserEditRequest body = UserEditRequest(
      name: name,
    );

    return apiService.patch(
      "users/$userId",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> editPasswordV2({
    required int userId,
    required String password,
    required String newPassword,
  }) async {
    UserEditPasswordRequest body = UserEditPasswordRequest(
      password: password,
      newPassword: newPassword,
    );

    return apiService.patch(
      "users/$userId/password",
      body.toJson(),
      (_) => null,
    );
  }
}
