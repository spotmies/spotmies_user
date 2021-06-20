import 'package:firebase_auth/firebase_auth.dart';

class API {
  static var uid = FirebaseAuth.instance.currentUser.uid; //user id
  static var host = 'spotmiesserver.herokuapp.com'; //server path
  static var createOrder = '/api/order/Create-Ord/$uid'; //post with user id
  static var getOrders = '/api/order/user/$uid'; //get with user id
  static var particularOrder = '/api/order/orders/'; //get with order id
  static var userRegister = '/api/user/newUser'; //post 
  static var userDetails = '/api/user/users/$uid'; //get with user id
  static var editOrder = '/api/order/orders/'; //put with order id
  static var deleteOrder = '/api/order/orders/'; //delete with order id
  static var confirmOrder = '/api/order/orders/'; //put with order id
  static var partnerDetails = '/api/partner/partners/';//get with partner id(pid) 
  static var complaintOnPartner = '/api/partner/complaint';
}
