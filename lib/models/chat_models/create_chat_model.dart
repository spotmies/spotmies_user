class CreateChat {
  String msgId;
  List<String> msgs;
  String ordId;
  String pId;
  String uId;
  String uDetails;
  String pDetails;
  String orderDetails;
  CreateChat(
      {this.msgId,
      this.msgs,
      this.ordId,
      this.pId,
      this.uId,
      this.uDetails,
      this.pDetails,
      this.orderDetails});

  CreateChat.fromJson(Map<String, dynamic> json) {
    msgId = json['msgId'];
    msgs = json['msgs'].cast<String>();
    ordId = json['ordId'];
    pId = json['pId'];
    uId = json['uId'];
    uDetails = json['uDetails'];
    pDetails = json['pDetails'];
    orderDetails = json['orderDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgId'] = this.msgId;
    data['msgs'] = this.msgs;
    data['ordId'] = this.ordId;
    data['pId'] = this.pId;
    data['uId'] = this.uId;
    data['uDetails'] = this.uDetails;
    data['pDetails'] = this.pDetails;
    data['orderDetails'] = this.orderDetails;
    return data;
  }
}
