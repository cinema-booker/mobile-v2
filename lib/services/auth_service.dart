import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/data/forget_password_request.dart';
import 'package:cinema_booker/data/reset_password_request.dart';
import 'package:cinema_booker/data/sign_in_request.dart';
import 'package:cinema_booker/data/sign_up_request.dart';
import 'package:cinema_booker/data/sign_in_response.dart';
import 'package:cinema_booker/data/get_me_response.dart';
import 'package:cinema_booker/services/web_socket_service.dart';

class AuthService {
  ApiService apiService = ApiService();
  final WebSocketService _webSocketService = WebSocketService();

  Future<ApiResponse<Null>> signUp({
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

  Future<ApiResponse<SignInResponse>> signIn({
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

  Future<ApiResponse<GetMeResponse>> me() async {
    return apiService.get<GetMeResponse>(
      "me",
      null,
      (data) {
        GetMeResponse getMeResponse = GetMeResponse.fromJson(data);
        if (getMeResponse.role == "MANAGER") {
          _webSocketService.connectWebSocket(getMeResponse.id);
        }
        return getMeResponse;
      },
    );
  }

  Future<ApiResponse<Null>> forgetPasswordV2({
    required String email,
  }) async {
    ForgetPasswordRequest body = ForgetPasswordRequest(
      email: email,
    );

    return apiService.post(
      "send-password-reset",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> resetPasswordV2({
    required String email,
    required String code,
    required String password,
  }) async {
    ResetPasswordRequest body = ResetPasswordRequest(
      email: email,
      code: code,
      password: password,
    );

    return apiService.post(
      "reset-password",
      body.toJson(),
      (_) => null,
    );
  }
}
