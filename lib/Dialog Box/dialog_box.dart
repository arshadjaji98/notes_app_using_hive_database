import 'package:flutter/material.dart';
import 'package:hive_database/Models/notes_model.dart';
import 'package:hive_database/Boxes/boxes.dart';

class AddNoteDialog extends StatefulWidget {
  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Notes"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Description',
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final data = NotesModel(
              title: titleController.text,
              discription: descriptionController.text,
            );
            final box = Boxes.getData();
            box.add(data);
            data.save();
            titleController.clear();
            descriptionController.clear();
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }

}
