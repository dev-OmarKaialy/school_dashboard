import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyEventDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const MyEventDialog({super.key, required this.onSubmit});

  @override
  _MyEventDialogState createState() => _MyEventDialogState();
}

class _MyEventDialogState extends State<MyEventDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  TimeOfDay _time = TimeOfDay.now();
  String _day = '';
  int _typeSectionId = 0;
  Duration _duration = const Duration(minutes: 0);

  // Helper function to show a date picker
  Future<void> _selectDateTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _time) {
      print(picked);
      setState(() {
        _time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Event Details'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => _name = value ?? '',
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Day'),
                onChanged: (value) => _day = value ?? '',
                validator: (value) => value!.isEmpty ? 'Enter a day' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type Section ID'),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    _typeSectionId = int.tryParse(value ?? '0') ?? 0,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a type section ID' : null,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _duration =
                    Duration(minutes: int.tryParse(value ?? '0') ?? 0),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a duration' : null,
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text("Time: ${_time.format(context)}".split(' ')[0]),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDateTime(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print({
                'name': _name,
                'time': DateFormat('HH:mm')
                    .format(DateTime(0, 0, 0, _time.hour, _time.minute)),
                'day': _day,
                'type_section_id': _typeSectionId,
                'duration': _duration.inMinutes,
              });
              widget.onSubmit({
                'name': _name,
                'time': DateFormat('HH:mm')
                    .format(DateTime(0, 0, 0, _time.hour, _time.minute)),
                'day': _day,
                'type_section_id': _typeSectionId,
                'duration': _duration.inMinutes,
              });
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
