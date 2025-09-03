class TotalPerDayDTO {
  final DateTime date;
  final double total;

  TotalPerDayDTO({
    required this.date,
    required this.total,
  });

  factory TotalPerDayDTO.fromJson(Map<String, dynamic> json) {
    return TotalPerDayDTO(
      date: DateTime.parse(json['date']),
      total: json['total'],
    );
  }
}