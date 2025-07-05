class OilChange {
  final int id;
  final int currentKm;
  final int oilLifeKm;
  final int avgKmPerDay;
  final int targetKm;
  final DateTime changeDate;

  OilChange({
    this.id = 0,
    required this.currentKm,
    required this.oilLifeKm,
    required this.avgKmPerDay,
    required this.targetKm,
    required this.changeDate,
  });

  factory OilChange.calculate({
    required int currentKm,
    required int oilLifeKm,
    required int avgKmPerDay,
  }) {
    final targetKm = currentKm + oilLifeKm;
    final days = oilLifeKm ~/ avgKmPerDay;
    final changeDate = DateTime.now().add(Duration(days: days));
    return OilChange(
      currentKm: currentKm,
      oilLifeKm: oilLifeKm,
      avgKmPerDay: avgKmPerDay,
      targetKm: targetKm,
      changeDate: changeDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_km': currentKm,
      'oil_life_km': oilLifeKm,
      'avg_km_per_day': avgKmPerDay,
      'target_km': targetKm,
      'change_date': changeDate.toIso8601String(),
    };
  }

  factory OilChange.fromMap(Map<String, dynamic> map) {
    return OilChange(
      id: map['id'],
      currentKm: map['current_km'],
      oilLifeKm: map['oil_life_km'],
      avgKmPerDay: map['avg_km_per_day'],
      targetKm: map['target_km'],
      changeDate: DateTime.parse(map['change_date']),
    );
  }
}
