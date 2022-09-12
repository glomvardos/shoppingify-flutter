import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/filter/filter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shoppingify/enums/button_type.dart';
import 'package:shoppingify/enums/shopping_list_status.dart';
import 'package:shoppingify/widgets/ui/buttons/button.dart';

class ShoppingListsFilter extends StatefulWidget {
  const ShoppingListsFilter({Key? key}) : super(key: key);

  @override
  State<ShoppingListsFilter> createState() => _ShoppingListsFilterState();
}

class _ShoppingListsFilterState extends State<ShoppingListsFilter> {
  DateTimeRange? _selectedDateRange;
  late ShoppingListStatus _selectedStatus;
  late FilterBloc _filterBloc;

  @override
  void initState() {
    _filterBloc = context.read<FilterBloc>();
    final state = _filterBloc.state;
    _selectedStatus = state.currentStatus;
    super.initState();
  }

  // This function will be triggered when the floating button is pressed
  void _showDatePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      initialDateRange:
          DateTimeRange(start: DateTime.now(), end: DateTime.now()),
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Shopping Lists',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'Filter by Date',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _showDatePicker,
                icon: const Icon(Icons.calendar_today),
              ),
              if (_selectedDateRange == null)
                GestureDetector(
                  onTap: _showDatePicker,
                  child: const Text('Select date range'),
                ),
              if (_selectedDateRange != null)
                Row(
                  children: [
                    Text(
                        '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDateRange = null;
                        });
                      },
                      icon: const Icon(Icons.clear),
                    )
                  ],
                )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Filter by Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          ...shoppingListStatusNames.entries
              .map((e) => RadioListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: Text(e.value),
                  value: e.key,
                  groupValue: _selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value as ShoppingListStatus;
                    });
                  }))
              .toList(),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            child: Button(
                type: ButtonType.primary,
                text: 'Apply Filters',
                onPressedHandler: () {
                  Navigator.of(context).pop();
                  context
                      .read<FilterBloc>()
                      .add(FilterList(status: _selectedStatus));
                }),
          )
        ],
      ),
    );
  }
}
