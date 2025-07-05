import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'oil_reminder_controller.dart';

class OilReminderBanner extends ConsumerWidget {
  const OilReminderBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oil = ref.watch(oilChangeProvider);
    final moyAlmashtirishVaqti =
        ref.read(oilChangeProvider.notifier).checkIfDue();

    if (oil == null) return const SizedBox();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: moyAlmashtirishVaqti
            ? const Color.fromARGB(255, 255, 0, 0)
            : const Color.fromARGB(255, 47, 255, 54),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Text(
        textAlign: TextAlign.center,
        moyAlmashtirishVaqti
            ? "Moy almashtirish vaqti keldi!"
            : "Moyni taxminan ${DateFormat('dd.MM.yyyy').format(oil.changeDate)} sanasida almashtiring",
        style: TextStyle(
          color: moyAlmashtirishVaqti ? Colors.white : Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
