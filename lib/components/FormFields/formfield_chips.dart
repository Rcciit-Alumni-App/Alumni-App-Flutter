import 'package:flutter/material.dart';

class TextfieldMultiController extends ChangeNotifier {
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

class FormFieldChips extends StatefulWidget {
  final TextfieldMultiController controller;
  final String? caption;
  final ValueChanged<List<String>>? onChanged;
  final ValueChanged<List<String>>? onSaved;

  const FormFieldChips({
    required this.controller,
    this.caption,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<FormFieldChips> createState() => _FormFieldChipsState();
}

class _FormFieldChipsState extends State<FormFieldChips> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSelectedItems);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSelectedItems);
    _textController.dispose();
    super.dispose();
  }

  void _updateSelectedItems() {
    setState(() {
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller.selectedItems);
      }
    });
  }

  void _addChip() {
    final text = _textController.text.trim();
    if (text.isNotEmpty && !widget.controller.selectedItems.contains(text)) {
      widget.controller.addItem(text);
      _textController.clear();
      if (widget.onSaved != null) {
        widget.onSaved!(widget.controller.selectedItems);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 16.0;
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color(0xFF2F80ED),
          width: 1.11053,
        ),
        color: Colors.grey[200]!.withOpacity(0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.caption != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.caption!,
                style: TextStyle(
                  color: Color(0xFF2F80ED),
                  fontSize: 17.0,
                ),
              ),
            ),
          Wrap(
            spacing: 6,
            runSpacing: -8,
            children: widget.controller.selectedItems
                .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Chip(
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
                              widget
                                  .onSaved!(widget.controller.selectedItems);
                            }
                          });
                        },
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        
                        deleteIconColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                ))
                .toList(),
          ),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Add an item',
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _addChip(),
          ),
        ],
      ),
    );
  }
}
