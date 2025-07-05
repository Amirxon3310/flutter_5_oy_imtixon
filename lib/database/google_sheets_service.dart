import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class SheetService {
  static late Worksheet _sheet;

  static Future<void> init() async {
    final jsonString = await rootBundle.loadString('assets/credentials.json');
    final credentialsMap = jsonDecode(jsonString);
    final gsheets = GSheets(credentialsMap);
    final spreadsheetId = '12S1YuocCmYapUO0RkrV1iQFI23TtvI2045PSkaqfqrQ';

    final spreadsheet = await gsheets.spreadsheet(spreadsheetId);
    final sheet = spreadsheet.worksheetByTitle('Лист1');

    if (sheet == null) {
      throw Exception('Sheet1 nomli worksheet topilmadi!');
    }

    _sheet = sheet;
  }

  static Future<bool> insertUser(
      String name, String email, String password) async {
    await _sheet.values.appendRow([name, email, password]);
    return true;
  }

  static Future<List<double>> getAllStatistic() async {
    final rows = await _sheet.values.allRows();

    if (rows.isEmpty || rows.length <= 1) return [0.0, 0.0, 0.0];

    final dataRows = rows.skip(1);

    double totalCurrentKm = 0;
    double totalOilLifeKm = 0;
    double totalAvgKm = 0;
    int count = 0;

    for (var row in dataRows) {
      if (row.length > 5) {
        final currentKm = double.tryParse(row[3]);
        final oilLifeKm = double.tryParse(row[4]);
        final avgKm = double.tryParse(row[5]);

        if (currentKm != null && oilLifeKm != null && avgKm != null) {
          totalCurrentKm += currentKm;
          totalOilLifeKm += oilLifeKm;
          totalAvgKm += avgKm;
          count++;
        }
      }
    }

    if (count == 0) return [0.0, 0.0, 0.0];

    return [
      totalCurrentKm / count,
      totalOilLifeKm / count,
      totalAvgKm / count,
    ];
  }

  static Future<bool> login(
      {required String email, required String password}) async {
    final rows = await _sheet.values.allRows();

    if (rows.isEmpty) return false;

    final dataRows = rows.skip(1);

    for (var row in dataRows) {
      if (row[1] == email && row[2] == password) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> addOil({
    required String email,
    required String currentKm,
    required String oilLifeKm,
    required String avgKm,
  }) async {
    final rows = await _sheet.values.allRows();

    if (rows.isEmpty) return false;

    final dataRows = rows.skip(1).toList();
    int index = 1;

    for (final row in dataRows) {
      if (row.contains(email)) {
        await _sheet.values.insertRow(index + 1, [
          row.isNotEmpty ? row[0] : '',
          row.length > 1 ? row[1] : '',
          row.length > 2 ? row[2] : '',
          currentKm,
          oilLifeKm,
          avgKm,
        ]);
        return true;
      }
      index++;
    }

    return false;
  }
}
