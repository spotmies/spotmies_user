import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:spotmies/apiCalls/apiExceptions.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/models/access_token.dart';
import 'package:spotmies/utilities/shared_preference.dart';

class Server {
  /* -------------------------- GET USER ACCESS TOKEN ------------------------- */

  Future<dynamic> getAccessTokenApi() async {
    log("getting access token");
    dynamic uri = Uri.https(API.host, API.accessToken);
    if (FirebaseAuth.instance.currentUser == null) return null;
    Map<String, String> body = {"uId": FirebaseAuth.instance.currentUser!.uid};
    try {
      dynamic response =
          await http.post(uri, body: body).timeout(Duration(seconds: 30));

      if (response?.statusCode == 200) {
        AccessToken result = AccessToken.fromJson(jsonDecode(response?.body));
        log("token ${result.token}");
        saveToken(result);
        return result;
      }
      return null;
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          message: 'API Not Responding in Time', url: uri.toString());
    }
  }

  Future<String> fetchAccessToken() async {
    if (FirebaseAuth.instance.currentUser == null) return "null";

    dynamic tokenDetails = await getToken();
    if (tokenDetails == null) {
      dynamic result = await getAccessTokenApi();
      if (result == null) return "null";
      return result.token.toString();
    } else {
      tokenDetails = AccessToken.fromJson(tokenDetails);
      if (tokenDetails.authData.exp <=
          (new DateTime.now().millisecondsSinceEpoch / 1000)) {
        dynamic result = await getAccessTokenApi();
        if (result == null) return "null";
        return result.token.toString();
      }
      return tokenDetails.token.toString();
    }
  }

  /* --------------------------- END OF ACCESS TOKEN -------------------------- */

  Future<dynamic> getMethod(String api, {Map<String, dynamic>? query}) async {
    var uri = Uri.https(API.host, api, {...?query, ...API.defaultQuery});
    final String accessToken = await fetchAccessToken();

    try {
      var response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $accessToken'},
      ).timeout(Duration(seconds: 30));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          message: 'API Not Responding in Time', url: uri.toString());
    }
  }

  Future<dynamic> getMethodParems(String api, queryParameters) async {
    var uri = Uri.https(API.host, api, queryParameters);

    print(uri);
    final String accessToken = await fetchAccessToken();
    try {
      dynamic response = await http.get(uri, headers: {
        'Authorization': 'Bearer $accessToken'
      }).timeout(Duration(seconds: 30));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          message: 'API Not Responding in Time', url: uri.toString());
    }
  }

  Future<dynamic> postMethod(String api, Map<String, dynamic> body,
      {Map<String, dynamic>? query}) async {
    var uri = Uri.https(API.host, api, {...?query, ...API.defaultQuery});
    // var bodyData = json.encode(body);
    final String accessToken = await fetchAccessToken();
    try {
      var response = await http.post(uri, body: body, headers: {
        'Authorization': 'Bearer $accessToken'
      }).timeout(Duration(seconds: 30));

      // return processResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          message: 'API Not Responding in Time', url: uri.toString());
    }
  }

  Future<dynamic> editMethod(String api, Map<String, dynamic> body,
      {Map<String, dynamic>? query}) async {
    var uri = Uri.https(API.host, api, {...?query, ...API.defaultQuery});
    // var bodyData = json.encode(body);
    final String accessToken = await fetchAccessToken();
    try {
      var response = await http.put(uri, body: body, headers: {
        'Authorization': 'Bearer $accessToken'
      }).timeout(Duration(seconds: 30));
      // print("45 $response");

      return processResponse(response);
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          message: 'API Not Responding in Time', url: uri.toString());
    }
  }

  Future<dynamic> deleteMethod(String api,
      {Map<String, dynamic>? params}) async {
    var uri = Uri.https(API.host, api, {...?params, ...API.defaultQuery});
    final String accessToken = await fetchAccessToken();

    try {
      var response = await http.delete(uri, headers: {
        'Authorization': 'Bearer $accessToken'
      }).timeout(Duration(seconds: 30));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          message: 'API Not Responding in Time', url: uri.toString());
    }
  }

  dynamic processResponse(http.Response response) {
    return response;
    // switch (response.statusCode) {
    //   case 200:
    //     var responseJson = utf8.decode(response.bodyBytes);
    //     //print(responseJson);
    //     return responseJson;
    //     break;
    //   case 400:
    //     throw BadRequestException(
    //         utf8.decode(response.bodyBytes), response.request.url.toString());
    //   case 404:
    //     return null;
    //   case 401:
    //   case 403:
    //     throw UnAuthorizedException(
    //         utf8.decode(response.bodyBytes), response.request.url.toString());
    //   case 500:
    //   default:
    //     throw FetchDataException(
    //         'Error occured with with code:${response.statusCode}',
    //         response.request.url.toString());
    // }
  }
}

// Future postMethod(String url, Map<String, dynamic> body) async {
//   try {
//     var response = await http.post(Uri.https(API.host, url), body: body);

//     if (response.statusCode == 200) {
//       String responseString = response?.body;
//       print(responseString);
//       return dataModelFromJson(responseString);
//     } else
//       return null;
//   } catch (e) {
//     print(e);
//   }
// }

// Future getMethod(String url) async {
//   var response = await http.get(Uri.https(API.host, url));
//   var jsonData = jsonDecode(response.body);
//   List<User> orders = [];

//   for (var u in jsonData) {
//     User user = User(u['problem'], u['money'].toString(), u['ordId'].toString(),
//         u['schedule'].toString());
//     orders.add(user);
//   }
//   if (response.statusCode == 200) {
//     print(orders.length);
//     return orders;
//   } else
//     return null;
// }
