import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/baseController.dart';

class TestController extends BaseController {
  void getData() async {
    var response =
        await Server().getMethod(API.createOrder).catchError(handleError);
    if (response == null) return;
    print(response);
  }

  void postData() async {
    var request = {'message': 'Spotmies Sucks!!!'};
    var response =
        await Server().postMethod(API.createOrder,request).catchError(handleError);
    if (response == null) return;
    print(response);
  }
}
