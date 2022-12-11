class Category {
    String mtgerCatId;
    String mtgerCatName;
    String mtgerCatPhoto;
    bool isSelected ;

    Category({
        this.mtgerCatId,
        this.mtgerCatName,
        this.mtgerCatPhoto,
        this.isSelected : false
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        mtgerCatId: json["mtger_cat_id"],
        mtgerCatName: json["mtger_cat_name"],
        mtgerCatPhoto: json["mtger_cat_photo"],
    );

    Map<String, dynamic> toJson() => {
        "mtger_cat_id": mtgerCatId,
        "mtger_cat_name": mtgerCatName,
        "mtger_cat_photo": mtgerCatPhoto,
    };
}