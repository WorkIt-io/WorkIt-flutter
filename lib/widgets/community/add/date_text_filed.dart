import 'package:flutter/material.dart';
import 'package:workit/utils/date_parser.dart';

class DateTextField extends StatefulWidget {
  const DateTextField({super.key, required this.onSave});

  final void Function(String? value) onSave;

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  String _dateTime = "";
  bool isValid = false;

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime;
      if (context.mounted) {
        pickedTime = await showTimePicker(
          context: context,
          helpText: 'Pick time for event:',
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dialOnly,
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
      }

      if (pickedTime != null) {
        DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _dateTime =
            formatCommunityDateTime(fullDateTime);
      } else {
        _dateTime = '';
      }
    } else {
      // not picked date
      _dateTime = '';
    }

    setState(() => _textEditingController.text = _dateTime);

    validate(_dateTime);
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        isValid = false;
      });
      return 'Pick a date';
    }
    setState(() {
      isValid = true;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      style: const TextStyle(fontSize: 18, color: Colors.black87),
      decoration: InputDecoration(
        label: const Text('Date'),
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black87),
        suffixIcon: isValid ? null : const Icon(Icons.date_range_sharp),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isValid ? Colors.green : Colors.white, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2)),
        hintText: 'Pick Date',
      ),
      onSaved: widget.onSave,
      validator: validate,
      onTap: () {
        // prevent the keyboard from showing up
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
      readOnly: true,
    );
  }
}
