import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotmies/miscellaneous/apimodel.dart';
import 'package:http/http.dart' as http;

getdata() async {
  var response = await http
      .get(Uri.https('spotmiesserver.herokuapp.com', 'api/order/orders'));
  var jsonData = jsonDecode(response.body);
  List<User> orders = [];

  for (var u in jsonData) {
    User user = User(u['problem'], u['money'].toString(), u['ordId'].toString(),
        u['schedule'].toString());
    orders.add(user);
  }
  if (response.statusCode == 200) {
    print(orders.length);
    return orders;
  } else
    return null;
  //print(users.length);
  // return users;
}

class NamedAPI extends StatefulWidget {
  @override
  _NamedAPIState createState() => _NamedAPIState();
}

class _NamedAPIState extends State<NamedAPI> {
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset-UTF-8"
  };

  // ignore: unused_field
  DataModel _dataModel;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController jobcontroller = TextEditingController();
  // Dio dio = Dio();
  // Future getdata() async {
  //   final String pathURL =
  //       'https://spotmiesserver.herokuapp.com/api/user/users/uId';
  //   final re = RequestOptions;

  //   dio.interceptors.add(InterceptorsWrapper(
  //       onRequest: (option, RequestInterceptorHandler) async {
  //     var headers = {
  //       'Content-type': 'appliction/json; charset=UTF-8',
  //       'Accept': 'application/json'
  //     };
  //     option.headers.addAll(headers);
  //     return option.data;
  //   }));
  //   Response response = await dio.get(pathURL);
  //   return response.data;
  // }

  Future submitdata(Map<String, dynamic> body) async {
    var response = await http.post(
        Uri.https('spotmiesserver.herokuapp.com', 'api/order/Create-Ord'),
        body: body);
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      // String responseString = response?.body;
      return response?.body;
      //dataModelFromJson(responseString);
    } else
      return null;
  }

  // Future addData(Map<String, String> body) async {
  //   final api =
  //       Uri.parse('https://spotmiesserver.herokuapp.com/api/order/Create-Ord');
  //   http.Response response =
  //       await http.post(api, headers: customHeaders, body: jsonEncode(body));
  //   return response.body;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            TextField(
              controller: jobcontroller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () async {
                  String problem = namecontroller.text;
                  String ordId =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  int ordState = 0;
                  int job = 1;
                  int schedule = 6555752235558;
                  //getdata();
                  submitdata({
                    "problem": problem,
                    "job": job.toString(),
                    "ordId": ordId,
                    "ordState": ordState.toString(),
                    "join": "5678543219876",
                    "schedule": schedule.toString(),
                    "uId": "9876543219876",
                    "loc.0": "18.222",
                    "loc.1": "23.526"
                  });

                  // DataModel data = await submitdata(name, job);
                  // setState(() {
                  //   _dataModel = data;
                  // });
                },
                child: Text('get'))
          ],
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Container(
  //     child: Card(
  //       child: FutureBuilder(
  //           future: getdata(),
  //           builder: (context, snapshot) {
  //             if (snapshot.data == null)
  //               return Center(child: CircularProgressIndicator());
  //             var doc = snapshot.data;
  //             return ListView.builder(
  //                 itemCount: doc.length,
  //                 itemBuilder: (context, i) {
  //                   return ListTile(
  //                     title: Text(doc[i].problem),
  //                     subtitle: Text(doc[i].money.toString()),
  //                     leading: Text(doc[i].ordid.toString()),
  //                     trailing: Text(doc[i].schedule.toString()),
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => Follow(value: i)));
  //                     },
  //                   );
  //                 });
  //           }),
  //     ),
  //   ));
  // }
}

class Follow extends StatefulWidget {
  final int value;
  Follow({this.value});
  @override
  _FollowState createState() => _FollowState(value);
}

class _FollowState extends State<Follow> {
  int value;
  _FollowState(this.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(value.toString()),
        ),
        body: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(child: CircularProgressIndicator());
              var doc = snapshot.data[value];
              return Column(
                children: [
                  Text(doc.problem),
                  Text(doc.ordid),
                  Text(doc.schedule),
                  Text(doc.money),
                ],
              );
              // ListView.builder(
              //     itemCount: 1,
              //     itemBuilder: (context, i) {
              //       return Column(
              //         children: [
              //           Text(doc[value].problem),
              //           Text(doc[value].ordid),
              //           Text(doc[value].schedule),
              //         ],
              //       );
              //     });
            }));
  }
}
