import 'package:firebase_auth/firebase_auth.dart';

class API {
  static var uid = FirebaseAuth.instance.currentUser.uid; //user id
  static var host = 'spotmiesserver.herokuapp.com'; //server path
  static var createOrder = '/api/order/Create-Ord/'; //post with user id
  static var getOrders = '/api/order/user/'; //get with user id
  static var particularOrder = '/api/order/orders/'; //get with order id
  static var userRegister = '/api/user/newUser'; //post
  static var userDetails = '/api/user/login'; //get with user id
  static var userLogout = "/api/user/logout";
  static var editOrder = '/api/order/orders/'; //put with order id
  static var deleteOrder = '/api/order/orders/'; //delete with order id
  static var confirmOrder = '/api/order/orders/'; //put with order id
  static var partnerDetails =
      '/api/partner/partners/'; //get with partner id(pid)
  static var complaintOnPartner = '/api/partner/complaint'; //post
  static var report = '/api/partner/report'; //put
  static var editPersonalInfo = '/api/user/users/'; //put
  static var reponse = '/api/response/user/';
  static var onlyResponses = "/api/response/responses/";
  static var localHost = '192.168.29.106:4000';
  static var places = '/api/geocode/all';
  static var userChatsList = '/api/chat/user/';
  static var createNewChat = '/api/chat/createNewChatRoom';
  static var confirmDeclineOrder = '/api/order/stateChange';
  static var revealProfile = "/api/order/revealProfile";
  static var specificChat = "/api/chat/chats/";
  static var cloudConstants = "/api/constant/doc-id/user_app";
  static var servicesList = "/api/services/all-service-list";
  static var serviceFeedBack = "/api/partner-feedback/new-feedback";
  static var newSuggestion = "/api/suggestion/new-suggestion";
  static var faq = "/api/support/faq/all-faqs";
}
