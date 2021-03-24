import 'package:http/http.dart' as http;
class VippsApi{

  static const String endpoint= 'https://apitest.vipps.no/';
  static const String client_id = 'fb492b5e-7907-4d83-ba20-c7fb60ca35de';
  static const String client_secret = 'Y8Kteew6GE2ZmeycEt6egg==';
  static const String sub_key = '0f14ebcab0ec4b29ae0cb90d91b4a84a';


  Future<dynamic> getAccessToken() async {
    var response = await http.post(Uri.http(endpoint, 'accesstoken/get'),
    headers : {
      "Accept" : "application/json",
      'client_id': client_id,
      'client_secret': client_secret,
      'Ocp-Apim-Subscription-Key': sub_key,
    });
    switch(response.statusCode){
      case 200:{
        print(response.body);
      }
      break;
    }
  }
}