class Order {
    String carttNumber;
    String carttFatora;
    String carttDate;
    String carttState;
    int carttTotlal;
    int rate;
    List<CarttDetail> carttDetails;

    Order({
        this.carttNumber,
        this.carttFatora,
        this.carttDate,
        this.carttState,
        this.carttTotlal,
        this.carttDetails,
         this.rate
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        carttNumber: json["cartt_number"] ?? '',
        carttFatora: json["cartt_fatora"] ?? '',
        carttDate: json["cartt_date"] ?? '',
        carttState: json["cartt_state"] ?? '',
        carttTotlal: json["cartt_totlal"] ?? 0,
            rate: json["rate"] ?? 0,
        carttDetails: List<CarttDetail>.from(json["cartt_details"].map((x) => CarttDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "cartt_number": carttNumber,
        "cartt_fatora": carttFatora,
        "cartt_date": carttDate,
        "cartt_state": carttState,
        "cartt_totlal": carttTotlal,
        "rate":rate.toString(),
        "cartt_details": List<dynamic>.from(carttDetails.map((x) => x.toJson())),
    };
}

class CarttDetail {
    String carttName;
    int carttAmount;
    int carttPrice;
    int carttAds;
    String options1Name;
    int options1Price;
    String options2Name;
    int options2Price;
    String options3Name;
    int options3Price;
    String options4Name;
    String options5Name;
    String carttPhoto;

    CarttDetail({
        this.carttName,
        this.carttAmount,
        this.carttPrice,
        this.carttAds,
        this.options1Name,
        this.options1Price,
        this.options2Name,
        this.options2Price,
        this.options3Name,
        this.options3Price,
        this.options4Name,
        this.options5Name,
        this.carttPhoto,
    });

    factory CarttDetail.fromJson(Map<String, dynamic> json) => CarttDetail(
        carttName: json["cartt_name"] ?? '',
        carttAmount: json["cartt_amount"] ?? 0,
        carttPrice: json["cartt_price"] ?? 0,
        carttAds: json["cartt_ads"] ?? 0,
        options1Name: json["options1_name"]  ?? '',
        options1Price: json["options1_price"] ?? 0,
        options2Name: json["options2_name"] ?? '',
        options2Price: json["options2_price"] ?? 0,
        options3Name: json["options3_name"] ?? '',
        options3Price: json["options3_price"] ?? 0,
        options4Name: json["options4_name"] ?? '',
        options5Name: json["options5_name"] ?? '',
        carttPhoto: json["cartt_photo"],
    );

    Map<String, dynamic> toJson() => {
        "cartt_name": carttName,
        "cartt_amount": carttAmount,
        "cartt_price": carttPrice,
        "cartt_ads": carttAds,
        "options1_name": options1Name,
        "options1_price": options1Price,
        "options2_name": options2Name,
        "options2_price": options2Price,
        "options3_name": options3Name,
        "options3_price": options3Price,
        "options4_name": options4Name,
        "options5_name": options5Name,
        "cartt_photo": carttPhoto,
    };
}
