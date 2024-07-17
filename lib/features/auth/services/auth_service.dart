import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/features/auth/data/sign_in_request.dart';
import 'package:cinema_booker/features/auth/data/sign_up_request.dart';
import 'package:cinema_booker/features/auth/data/sign_in_response.dart';
import 'package:cinema_booker/features/auth/data/get_me_response.dart';
import 'package:cinema_booker/features/webSocket/web_socket_service.dart';

class AuthService {
  ApiService apiService = ApiService();
  final WebSocketService _webSocketService = WebSocketService();

  Future<ApiResponse<Null>> signUpV2({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    SignUpRequest body = SignUpRequest(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    return apiService.post(
      "sign-up",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<SignInResponse>> signInV2({
    required String email,
    required String password,
  }) async {
    SignInRequest body = SignInRequest(
      email: email,
      password: password,
    );

    return apiService.post(
      "sign-in",
      body.toJson(),
      (data) {
        SignInResponse signInResponse = SignInResponse.fromJson(data);
        return signInResponse;
      },
    );
  }

  Future<ApiResponse<GetMeResponse>> meV2() async {
    return apiService.get<GetMeResponse>(
      "me",
      null,
      (data) {
        GetMeResponse getMeResponse = GetMeResponse.fromJson(data);
        if(getMeResponse.role == "MANAGER"){
          _webSocketService.connectWebSocket(getMeResponse.id);
        }
        return getMeResponse;
      },
    );
  }

  // void signUp({
  //   required BuildContext context,
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     SignUpRequest body = SignUpRequest(
  //       name: name,
  //       email: email,
  //       password: password,
  //       role: 'VIEWER',
  //     );

  //     http.Response response = await http.post(
  //       Uri.parse('http://10.0.2.2:3000/sign-up'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: body.toJson(),
  //     );

  //     httpErrorHandler(
  //       response: response,
  //       context: context,
  //       onSuccess: () {
  //         showSnackBarError(context: context, message: 'Sign up successful');
  //         context.goNamed(AppRouter.signIn);
  //       },
  //     );
  //   } catch (error) {
  //     showSnackBarError(
  //       context: context,
  //       message: error.toString(),
  //     );
  //   }
  // }

  // void signIn({
  //   required BuildContext context,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     SignInRequest body = SignInRequest(
  //       email: email,
  //       password: password,
  //     );

  //     http.Response response = await http.post(
  //       Uri.parse('http://10.0.2.2:3000/sign-in'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: body.toJson(),
  //     );

  //     httpErrorHandler(
  //       response: response,
  //       context: context,
  //       onSuccess: () async {
  //         SignInResponse signInResponse =
  //             SignInResponse.fromJson(response.body);

  //         SharedPreferences preferences = await SharedPreferences.getInstance();
  //         await preferences.setString(
  //           'cinema-booker-token',
  //           signInResponse.token,
  //         );

  //         // Provider.of<AuthProvider>(context, listen: false).setUser(
  //         //   signInResponse.id,
  //         //   signInResponse.name,
  //         //   signInResponse.email,
  //         //   signInResponse.role,
  //         // );

  //         getMe(context: context);

  //         showSnackBarError(context: context, message: 'Sign in successful');
  //         context.goNamed(AppRouter.home);
  //       },
  //     );
  //   } catch (error) {
  //     showSnackBarError(
  //       context: context,
  //       message: error.toString(),
  //     );
  //   }
  // }

  // void getMe({required BuildContext context}) async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString('cinema-booker-token');

  //     http.Response response = await http.get(
  //       Uri.parse('http://10.0.2.2:3000/me'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     httpErrorHandler(
  //       response: response,
  //       context: context,
  //       onSuccess: () async {
  //         GetMeResponse getMeResponse = GetMeResponse.fromJson(response.body);

  //         Provider.of<AuthProvider>(context, listen: false).setUser(
  //           getMeResponse.id,
  //           getMeResponse.name,
  //           getMeResponse.email,
  //           getMeResponse.role,
  //           getMeResponse.cinemaId,
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
