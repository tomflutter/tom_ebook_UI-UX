class SignInModel {
  static List<SignInItem> list = [];

  SignInModel.getuserid(dynamic obj) {
    list = obj
        .map<SignInItem>((jsonMapMap) => new SignInItem.fromJsonMap(jsonMapMap))
        .toList();
  }
}

class SignInItem {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userToken;

  SignInItem({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userToken,
  });

  factory SignInItem.fromJsonMap(Map<String, dynamic> jsonMap) {
    return SignInItem(
      userId: jsonMap["user_id"],
      userName: jsonMap["user_name"],
      userEmail: jsonMap["user_email"],
      userPhone: jsonMap["user_phone"],
      userToken: jsonMap["user_token"],
    );
  }
}
