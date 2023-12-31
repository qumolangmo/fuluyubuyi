import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect({super.key,required this.items});
  final List<String> items;
  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue,bool isSelected){
    setState(() {
      if(isSelected){
        _selectedItems.add(itemValue);
      }
      else{
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel(){
    Navigator.pop(context);
  }

  void _submit(){
    Navigator.pop(context,_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("请选择要统计的参数"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
            .map((item) => CheckboxListTile(
              value: _selectedItems.contains(item), 
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked)=>_itemChange(item, isChecked!),
            ))
            .toList()
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel, 
          child: const Text("取消")
        ),
        TextButton(
          onPressed: _submit,
          child: const Text("确定")
        )
      ],
    );
  }
}