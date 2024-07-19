// ignore_for_file: use_build_context_synchronously

import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/data/booking_create_request.dart';
import 'package:cinema_booker/data/booking_create_response.dart';
import 'package:cinema_booker/data/booking_list_response.dart';

class BookingService {
  ApiService apiService = ApiService();

  Future<ApiResponse<List<BookingListItem>>> list({
    int page = 1,
    int limit = 10,
    String search = '',
  }) {
    return apiService.get<List<BookingListItem>>(
      "bookings",
      {
        'page': page.toString(),
        'limit': limit.toString(),
        'search': search,
      },
      (data) {
        BookingListResponse bookingListResponse =
            BookingListResponse.fromJson(data);
        return bookingListResponse.bookings;
      },
    );
  }

  Future<ApiResponse<BookingListItem>> details({
    required int bookingId,
  }) async {
    return apiService.get<BookingListItem>(
      "bookings/$bookingId",
      null,
      (data) {
        BookingListItem bookingListItem = BookingListItem.fromJson(data);
        return bookingListItem;
      },
    );
  }

  Future<ApiResponse<BookingCreateResponse>> create({
    required int sessionId,
    required List<String> seats,
  }) async {
    BookingCreateRequest body = BookingCreateRequest(
      sessionId: sessionId,
      seats: seats,
    );

    return apiService.post(
      "bookings",
      body.toJson(),
      (data) {
        BookingCreateResponse bookingCreateResponse =
            BookingCreateResponse.fromJson(data);
        return bookingCreateResponse;
      },
    );
  }
}
