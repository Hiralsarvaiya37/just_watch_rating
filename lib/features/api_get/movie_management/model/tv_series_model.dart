class TvSeriesModel {
  final String title;
  final String description;
  final String image;
  final double rating;

  TvSeriesModel({
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    final item = json['listItem'];
    return TvSeriesModel(
      title: item['originalTitleText'] ?? '',
      description: item['plot'] ?? '',
      image: item['primaryImage']?['url'] ?? '',
      rating: (item['ratingSummary']?['aggregateRating'] ?? 0).toDouble(),
    );
  }
}
