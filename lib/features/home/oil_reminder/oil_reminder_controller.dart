import 'package:flutter_5_oy_imtixon/database/oil_change_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/oil_change_model.dart';

final oilChangeProvider =
    StateNotifierProvider<OilChangeNotifier, OilChange?>((ref) {
  return OilChangeNotifier();
});

class OilChangeNotifier extends StateNotifier<OilChange?> {
  OilChangeNotifier() : super(null) {
    loadLatest();
  }

  Future<void> loadLatest() async {
    state = await OilChangeDB.instance.getLastOilChange();
  }

  Future<void> addOilChangeData({
    required int currentKm,
    required int oilLifeKm,
    required int avgKmPerDay,
  }) async {
    final oil = OilChange.calculate(
      currentKm: currentKm,
      oilLifeKm: oilLifeKm,
      avgKmPerDay: avgKmPerDay,
    );
    await OilChangeDB.instance.insertOilChange(oil);
    state = oil;
  }

  bool checkIfDue() {
    if (state == null) return false;
    return state!.changeDate.isBefore(DateTime.now()) ||
        state!.changeDate.isAtSameMomentAs(DateTime.now());
  }
}
