import "dart:convert";

import "package:http/http.dart" as http;
import "package:stripe_checkout/stripe_checkout.dart";

class StripeService {
  static String secretKey =
      "your_secret_key";
  static String publishableKey =
      "your_publishable_key";

  static Future<dynamic> createCheckoutSession(
    int sessionId,
    List<String> seats,
    int price,
  ) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

    String lineItems = "";
    int index = 0;
    var productPrice = (price * 100).round().toString();

    for (var seat in seats) {
      lineItems += "&line_items[$index][price_data][product_data][name]=$seat";
      lineItems += "&line_items[$index][price_data][unit_amount]=$productPrice";
      lineItems += "&line_items[$index][price_data][currency]=EUR";
      lineItems += "&line_items[$index][quantity]=1";

      index++;
    }

    String seatsJson = jsonEncode(seats);
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body:
          "success_url=https://example.com/success&mode=payment$lineItems&metadata[session_id]=$sessionId&metadata[seats]=$seatsJson",
    );

    return json.decode(response.body)["id"];
  }

  static Future<dynamic> stripePaymentCheckout(
    sessionId,
    seats,
    price,
    context,
    mounted, {
    onSuccess,
    onCancel,
    onError,
  }) async {
    final String checkoutId = await createCheckoutSession(
      sessionId,
      seats,
      price,
    );

    final result = await redirectToCheckout(
      context: context,
      sessionId: checkoutId,
      publishableKey: publishableKey,
      successUrl: "https://example.com/success",
      canceledUrl: "https://example.com/cancel",
    );

    if (mounted) {
      final text = result.when(
        redirected: () => "Redirected to checkout",
        success: () => onSuccess(),
        canceled: () => onCancel(),
        error: (e) => onError(e),
      );

      return text;
    }
  }
}
