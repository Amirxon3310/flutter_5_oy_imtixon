import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_5_oy_imtixon/controller/my_controller.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/custom_button.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/custom_text_field.dart';
import 'package:flutter_5_oy_imtixon/core/widgets/input_formatters.dart';
import 'package:flutter_5_oy_imtixon/database/google_sheets_service.dart';
import 'package:flutter_5_oy_imtixon/features/home/oil_reminder/oil_banner_widget.dart';
import 'package:flutter_5_oy_imtixon/features/home/oil_reminder/statistic_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'oil_reminder_controller.dart';

class OilInputScreen extends ConsumerWidget {
  final String email;
  final _formKey = GlobalKey<FormState>();
  final _currentKm = TextEditingController();
  final _oilLifeKm = TextEditingController();
  final _avgKm = TextEditingController();
  final myController = MyController();

  OilInputScreen(this.email, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Moy Eslatma',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatisticScreen(),
                ),
              );
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 24,
              children: [
                OilReminderBanner(),
                SizedBox(height: 32),
                CustomTextfield(
                    label: Text("Hozirgi probeg"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ReverseSpaceEveryThreeDigitsFormatter(),
                    ],
                    controller: _currentKm,
                    width: double.infinity,
                    keyboardType: TextInputType.number,
                    onChanged: (a) {},
                    hintext: "",
                    onTapTextField: () {},
                    validator: (v) {
                      if (v!.isEmpty) return 'To‘ldiring';
                      if (v.length > 18) {
                        return "Eng ko'pi 18 xonali raqam kirata olasiz";
                      }
                      return null;
                    }),
                CustomTextfield(
                    label: Text("Moy resursi (km)"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ReverseSpaceEveryThreeDigitsFormatter(),
                    ],
                    controller: _oilLifeKm,
                    width: double.infinity,
                    keyboardType: TextInputType.number,
                    onChanged: (a) {},
                    hintext: "",
                    onTapTextField: () {},
                    validator: (v) {
                      if (v!.isEmpty) return 'To‘ldiring';
                      if (v.length > 18) {
                        return "Eng ko'pi 18 xonali raqam kirata olasiz";
                      }
                      return null;
                    }),
                CustomTextfield(
                    label: Text("Kunlik o‘rtacha km"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ReverseSpaceEveryThreeDigitsFormatter(),
                    ],
                    controller: _avgKm,
                    width: double.infinity,
                    keyboardType: TextInputType.number,
                    onChanged: (a) {},
                    hintext: "",
                    onTapTextField: () {},
                    validator: (v) {
                      if (v!.isEmpty) return 'To‘ldiring';
                      if (int.tryParse(v) == 0) return '0 bo‘lishi mumkin emas';
                      if (v.length > 18) {
                        return "Eng ko'pi 18 xonali raqam kirata olasiz";
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                Obx(() {
                  return myController.isLoadingAuth.value
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : CustomButton(
                          text: "Hisobla va saqla",
                          height: 70,
                          width: double.infinity,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              myController.isLoadingAuth.value = true;
                              await ref
                                  .read(oilChangeProvider.notifier)
                                  .addOilChangeData(
                                    currentKm: int.parse(
                                        _currentKm.text.replaceAll(' ', '')),
                                    oilLifeKm: int.parse(
                                        _oilLifeKm.text.replaceAll(' ', '')),
                                    avgKmPerDay: int.parse(
                                        _avgKm.text.replaceAll(' ', '')),
                                  );

                              await SheetService.addOil(
                                email: email,
                                currentKm: _currentKm.text,
                                oilLifeKm: _oilLifeKm.text,
                                avgKm: _avgKm.text,
                              );
                              myController.isLoadingAuth.value = false;

                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                  ..clearSnackBars()
                                  ..showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Moy eslatmasi saqlandi')),
                                  );
                              }
                            }
                          },
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
