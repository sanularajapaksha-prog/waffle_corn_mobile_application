import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  final List<String> _addresses = [
    '42 Ocean View Avenue, Colombo 03',
    '16 Hill Street, Maharagama',
  ];

  Future<void> _addAddress() async {
    final value = await _showAddressDialog();
    if (value != null && value.isNotEmpty) setState(() => _addresses.add(value));
  }

  Future<String?> _showAddressDialog({String initialValue = ''}) async {
    final controller = TextEditingController();
    controller.text = initialValue;
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(initialValue.isEmpty ? 'Add address' : 'Edit address'),
        content: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Address')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text('Save')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Saved Address')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _addAddress,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _addresses.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () async {
              final updated = await _showAddressDialog(initialValue: _addresses[index]);
              if (updated != null && updated.isNotEmpty) {
                setState(() => _addresses[index] = updated);
              }
            },
            title: Text(_addresses[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => setState(() => _addresses.removeAt(index)),
            ),
          ),
        ),
      ),
    );
  }
}
