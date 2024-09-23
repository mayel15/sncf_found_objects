import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangeFilter extends StatefulWidget {
  final Function(String) onDateRangeSelected; // Callback pour renvoyer la plage de dates sélectionnée

  const DateRangeFilter({Key? key, required this.onDateRangeSelected}) : super(key: key);

  @override
  _DateRangeFilterState createState() => _DateRangeFilterState();
}

class _DateRangeFilterState extends State<DateRangeFilter> {
  String _range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - '
            '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      });
      widget.onDateRangeSelected(_range); // Appelle la fonction de rappel
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Plage de dates sélectionnée: $_range',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3)),
            ),
          ),
        ),
      ],
    );
  }
}
