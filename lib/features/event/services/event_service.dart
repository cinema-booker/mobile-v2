import 'package:cinema_booker/api/api_response.dart';
import 'package:cinema_booker/api/api_service.dart';
import 'package:cinema_booker/features/event/data/event_create_request.dart';
import 'package:cinema_booker/features/event/data/event_details_response.dart';
import 'package:cinema_booker/features/event/data/event_list_response.dart';
import 'package:cinema_booker/features/event/data/movie_autocomplete_item.dart';

class EventService {
  ApiService apiService = ApiService();

  Future<ApiResponse<List<EventListItem>>> listV2({
    int page = 1,
    int limit = 10,
    String search = '',
  }) {
    return apiService.get<List<EventListItem>>(
      "events",
      {
        'page': page.toString(),
        'limit': limit.toString(),
        'search': search,
      },
      (data) {
        EventListResponse eventListResponse = EventListResponse.fromJson(data);
        return eventListResponse.events;
      },
    );
  }

  Future<ApiResponse<EventDetailsResponse>> detailsV2({
    required int eventId,
  }) async {
    return apiService.get<EventDetailsResponse>(
      "events/$eventId",
      null,
      (data) {
        EventDetailsResponse eventDetailsResponse =
            EventDetailsResponse.fromJson(data);
        return eventDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> createV2({
    required int cinemaId,
    required MovieAutoCompleteItem movie,
  }) async {
    EventCreateRequest body = EventCreateRequest(
      cinemaId: cinemaId,
      movie: movie,
    );

    return apiService.post(
      "events",
      body.toJson(),
      (_) => null,
    );
  }
}
