class offerModel {
  String title,
      description,
      location,
      fullDescription,
      price,
      category,
      offerId,
      imageUrl;

  offerModel(
      {required this.title,
      required this.offerId,
      required this.description,
      required this.price,
      required this.location,
      required this.fullDescription,
      required this.category,
      required this.imageUrl});
}
