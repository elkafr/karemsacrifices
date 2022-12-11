import 'package:karemsacrifices/models/city.dart';

class User {
    String userId;
    String userName;
    String userEmail;
    String userPhone;
    City userCity;

    User({
        this.userId,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.userCity,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userCity: City.fromJson(json["user_city"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_city": userCity.toJson(),
    };
}
