import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/data/user_edit_request.dart';
import 'package:cinema_booker/features/user/data/user_list_response.dart';

class UserService {
  ApiService apiService = ApiService();

  Future<ApiResponse<List<UserListItem>>> listV2({
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

  Future<ApiResponse<UserDetailsResponse>> detailsV2({
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

  Future<ApiResponse<Null>> editV2({
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

  // Future<List<UserListItem>> list({
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
  //         'http://10.0.2.2:3000/users?page=$page&limit=$limit&search=$search',
  //       ),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       UserListResponse userListResponse =
  //           UserListResponse.fromJson(response.body);
  //       return userListResponse.users;
  //     } else {
  //       showSnackBarError(
  //         context: context,
  //         message: 'Failed to fetch user list',
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

  // Future<UserDetailsResponse?> details({
  //   required BuildContext context,
  //   required int userId,
  // }) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.get(
  //       Uri.parse('http://10.0.2.2:3000/users/$userId'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       UserDetailsResponse userDetailsResponse =
  //           UserDetailsResponse.fromJson(response.body);
  //       return userDetailsResponse;
  //     } else {
  //       showSnackBarError(
  //         context: context,
  //         message: 'Failed to fetch user details',
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

  // void edit({
  //   required BuildContext context,
  //   required int userId,
  //   required String name,
  // }) async {
  //   try {
  //     UserEditRequest body = UserEditRequest(
  //       name: name,
  //     );

  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.patch(
  //       Uri.parse('http://10.0.2.2:3000/users/$userId'),
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
  //           message: 'User updated successfully',
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
}
