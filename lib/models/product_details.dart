class ProductDetails {
    String adsMtgerId;
    String adsMtgerName;
    String adsMtgerCat;
    String adsMtgerContent;
    bool isAddToCart;
    String adsMtgerPhoto;

    ProductDetails({
        this.adsMtgerId,
        this.adsMtgerName,
        this.adsMtgerCat,
        this.adsMtgerContent,
        this.isAddToCart,
        this.adsMtgerPhoto,
    });

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        adsMtgerId: json["ads_mtger_id"],
        adsMtgerName: json["ads_mtger_name"],
        adsMtgerCat: json["ads_mtger_cat"],
        adsMtgerContent: json["ads_mtger_content"],
        isAddToCart: json["is_add_to_cart"],
        adsMtgerPhoto: json["ads_mtger_photo"],
    );

    Map<String, dynamic> toJson() => {
        "ads_mtger_id": adsMtgerId,
        "ads_mtger_name": adsMtgerName,
        "ads_mtger_cat": adsMtgerCat,
        "ads_mtger_content": adsMtgerContent,
        "is_add_to_cart": isAddToCart,
        "ads_mtger_photo": adsMtgerPhoto,
    };
}
