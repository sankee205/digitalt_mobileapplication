import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

///
///this class is currently not used
class VippsApi {
  static const String _base_url = "apitest.vipps.no";
  static const String _client_id = "67a9c4f8-0e21-4b89-bf94-daa6abb7b166";
  static const String _client_secret = "6-lnEIve7NKxxbzGiYjgfMN-3WA=";
  static const String _merchantSerialNumber = "218468";
  static const String _sub_key = "5c194972d7994fe284168479cd99bef1";

  String _accessToken;
  String _orderId;

  Future<String> getAccessToken() async {
    http.Response response = await http.post(
      Uri.https(_base_url, "accessToken/get"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "client_id": _client_id,
        "client_secret": _client_secret,
        "Ocp-Apim-Subscription-Key": _sub_key,
      },
    );
    final body = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        {
          final String token = body['access_token'];
          _accessToken = token;
          return token;
        }
        break;
    }
    return null;
  }

  Future<String> initiatePayment(String phoneNumber) async {
    String randomNumber = Random().nextInt(1000).toString();
    Map requestBody = {
      "customerInfo": {"mobileNumber": "90232609"},
      "merchantInfo": {
        "merchantSerialNumber": _merchantSerialNumber,
        "callbackPrefix":
            "https://example.com/vipps/callbacks-for-payment-update",
        "isApp": 'false',
        "fallBack":
            "https://example.com/vipps/fallback-result-page/acme-shop-" +
                randomNumber +
                "-order" +
                randomNumber +
                "abc"
      },
      "transaction": {
        "orderId":
            "acme-shop-" + randomNumber + "-order" + randomNumber + "abc",
        "amount": '105000',
        "transactionText": "One year subscription"
      }
    };
    http.Response response =
        await http.post(Uri.https(_base_url, 'ecomm/v2/payments'),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ' + _accessToken,
              'Ocp-Apim-Subscription-Key': _sub_key,
              'Merchant-Serial-Number': _merchantSerialNumber
            },
            body: json.encode(requestBody));
    final body = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        {
          _orderId = body['orderId'];
          final String result = body['url'];
          return result;
        }
        break;
    }
    return null;
  }

  Future getPaymentDetails() async {
    Map<String, String> standardHeaders = <String, String>{
      "Content-Type": "application/json",
      'Ocp-Apim-Subscription-Key': _sub_key,
      'Merchant-Serial-Number': _merchantSerialNumber,
      'Authorization': 'Bearer $_accessToken',
    };
    http.Response response = await http.get(
      Uri.https(_base_url, "/ecomm/v2/payments/$_orderId/details"),
      headers: standardHeaders,
    );
    return response.statusCode.toString();
  }

  Future capturePayment() async {
    Map requestBody = {
      "merchantInfo": {"merchantSerialNumber": _merchantSerialNumber},
      "transaction": {
        "amount": "105000",
        "transactionText": "One year subscription"
      }
    };
    http.Response response = await http.post(
        Uri.https(_base_url, "/ecomm/v2/payments/$_orderId/capture"),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer $_accessToken',
          'Ocp-Apim-Subscription-Key': _sub_key,
          'X-Request-Id': _orderId + 'XIDC1',
          'Merchant-Serial-Number': _merchantSerialNumber
        },
        body: json.encode(requestBody));
    if (response.statusCode == 200) {
      final body = response.body.toString();
      return body;
    } else {
      return response.statusCode.toString();
    }
  }

  Future cancelPayment() async {}

  Future getOrderStatus() async {}
  Future refundPayment() async {}
}
