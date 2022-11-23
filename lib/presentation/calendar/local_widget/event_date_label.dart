import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/utils/typography.dart';

class EventDateLabel extends StatelessWidget {
  const EventDateLabel({
    Key? key,
    required DateTime? selectedDay,
  })  : _selectedDay = selectedDay,
        super(key: key);

  final DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(
        DateFormat('EEEE, dd MMMM yyyy').format(_selectedDay!),
        style: BryteTypography.headerSemiBold,
      ),
    );
  }
}
