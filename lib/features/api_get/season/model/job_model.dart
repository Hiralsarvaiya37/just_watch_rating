class JobModel {
  final String country;
  final String countryCode;
  final String currency;
  final double minMonthlySalary;
  final double maxMonthlySalary;

  JobModel({
    required this.country,
    required this.countryCode,
    required this.currency,
    required this.minMonthlySalary,
    required this.maxMonthlySalary,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    final monthly = data['monthlySalary'] as Map<String, dynamic>? ?? {};

    return JobModel(
      country: data['country']?.toString() ?? 'N/A',
      countryCode: data['countryCode']?.toString() ?? 'N/A',
      currency: data['currency']?.toString() ?? 'N/A',
      minMonthlySalary: (monthly['min'] as num?)?.toDouble() ?? 0.0,
      maxMonthlySalary: (monthly['max'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return "Country: $country ($countryCode), Currency: $currency, "
        "Monthly → Min: $minMonthlySalary | Max: $maxMonthlySalary";
  }
}