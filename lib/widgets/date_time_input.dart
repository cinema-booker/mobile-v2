import 'package:cinema_booker/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatefulWidget {
  final TextEditingController controller;
  final DateTime? defaultValue;

  const DateTimeInput({
    super.key,
    required this.controller,
    this.defaultValue,
  });

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.defaultValue ?? DateTime.now();
    widget.controller.text = _formatDateTime(_selectedDateTime);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          widget.controller.text = _formatDateTime(_selectedDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hint: "Date and time",
      controller: widget.controller,
      isReadyOnly: true,
      onTap: () => _selectDateTime(context),
    );
  }
}
