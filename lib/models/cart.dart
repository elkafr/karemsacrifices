class Cart {
    String title;
    String cartId;
    int cartAmount;
    String options1Name;
    String options1Price;
    String options2Name;
    String options2Price;
    String options3Name;
    String options3Price;
    String options4Name;
    String options5Name;
    int price;
    String adsMtgerPhoto;

    Cart({
        this.title,
        this.cartId,
        this.cartAmount,
        this.options1Name,
        this.options1Price,
        this.options2Name,
        this.options2Price,
        this.options3Name,
        this.options3Price,
        this.options4Name,
        this.options5Name,
        this.price,
        this.adsMtgerPhoto,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        title: json["title"],
        cartId: json["cart_id"],
        cartAmount: json["cart_amount"],
        options1Name: json["options1_name"],
        options1Price: json["options1_price"],
        options2Name: json["options2_name"],
        options2Price: json["options2_price"],
        options3Name: json["options3_name"],
        options3Price: json["options3_price"],
        options4Name: json["options4_name"],
        options5Name: json["options5_name"],
        price: json["price"],
        adsMtgerPhoto: json["ads_mtger_photo"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "cart_id": cartId,
        "cart_amount": cartAmount,
        "options1_name": options1Name,
        "options1_price": options1Price,
        "options2_name": options2Name,
        "options2_price": options2Price,
        "options3_name": options3Name,
        "options3_price": options3Price,
        "options4_name": options4Name,
        "options5_name": options5Name,
        "price": price,
        "ads_mtger_photo": adsMtgerPhoto,
    };
}
