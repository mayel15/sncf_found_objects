import 'package:flutter/material.dart';

class DateRangePickerButton extends StatefulWidget {
  final Function(DateTimeRange?) onDateRangeSelected;

  DateRangePickerButton({required this.onDateRangeSelected});

  @override
  _DateRangePickerButtonState createState() => _DateRangePickerButtonState();
}

class _DateRangePickerButtonState extends State<DateRangePickerButton> {
  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });

      // Vérifier que cette partie appelle correctement la fonction pour filtrer
      print("Plage de date sélectionnée : ${_selectedDateRange!.start} - ${_selectedDateRange!.end}");
      widget.onDateRangeSelected(_selectedDateRange); // Appel du callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.date_range, color: Colors.black),
      onPressed: () => _selectDateRange(context),
    );
  }
}
