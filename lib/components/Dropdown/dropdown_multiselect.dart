import 'package:flutter/material.dart';

class DropdownMultiController extends ChangeNotifier {
  List<String> _selectedItems = [];

  List<String> get selectedItems => _selectedItems;

  set selectedItems(List<String> newItems) {
    _selectedItems = newItems;
    notifyListeners();
  }

  void addItem(String item) {
    if (!_selectedItems.contains(item)) {
      _selectedItems.add(item);
      notifyListeners();
    }
  }

  void removeItem(String item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
      notifyListeners();
    }
  }

  void clear() {
    _selectedItems = [];
    notifyListeners();
  }
}

class DropdownMulti extends StatefulWidget {
  final DropdownMultiController controller;
  final String? caption;
  final ValueChanged<List<String>>? onChanged;
  final ValueChanged<List<String>>? onSaved;

  const DropdownMulti({
    required this.controller,
    this.caption,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<DropdownMulti> createState() => _DropdownMultiState();
}

class _DropdownMultiState extends State<DropdownMulti> {
  List<String> menuItems = [
    'Technology',
    'Healthcare',
    'Finance',
    'Education',
    'E-commerce',
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSelectedItems);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSelectedItems);
    super.dispose();
  }

  void _updateSelectedItems() {
    setState(() {
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.selectedItems);
      }
    });
  }

  void _showMultiSelectDialog() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (context) {
        return MultiSelectDialog(
          items: menuItems,
          selectedItems: widget.controller.selectedItems,
        );
      },
    );

    if (results != null) {
      widget.controller.selectedItems = results;
      if (widget.onSaved != null) {
        widget.onSaved!(widget.controller.selectedItems);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;

    return Container(
      height: 50,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color(0xFF2F80ED),
          width: 1.11053,
        ),
        color: Colors.grey[200],
      ),
      child: GestureDetector(
        onTap: _showMultiSelectDialog,
        child: Row(
          children: [
            Text(
              widget.caption ?? "Select Items",
              style: TextStyle(
                color: Color(0xFF2F80ED),
                fontSize: 17.0,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 6,
                  runSpacing: -8,
                  children: widget.controller.selectedItems
                      .map((item) => Chip(
                            label: Text(item),
                            deleteIcon: Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                widget.controller.removeItem(item);
                                if (widget.onChanged != null) {
                                  widget.onChanged!(
                                      widget.controller.selectedItems);
                                }
                                if (widget.onSaved != null) {
                                  widget.onSaved!(
                                      widget.controller.selectedItems);
                                }
                              });
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            deleteIconColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Color(0xFF2F80ED)),
          ],
        ),
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  MultiSelectDialog({required this.items, required this.selectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _tempSelectedItems;

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Items'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              title: Text(item),
              value: _tempSelectedItems.contains(item),
              onChanged: (bool? checked) {
                setState(() {
                  if (checked == true) {
                    _tempSelectedItems.add(item);
                  } else {
                    _tempSelectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context, _tempSelectedItems);
          },
        ),
      ],
    );
  }
}
