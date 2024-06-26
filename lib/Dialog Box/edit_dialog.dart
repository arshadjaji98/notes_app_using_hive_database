import 'package:flutter/material.dart';
import 'package:hive_database/Models/notes_model.dart';

class EditNoteDialog extends StatefulWidget {
  final NotesModel notesModel;
  final String title;
  final String description;

  const EditNoteDialog({
    Key? key,
    required this.notesModel,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _EditNoteDialogState createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Notes"),
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
            widget.notesModel.title = titleController.text.toString();
            widget.notesModel.discription =
                descriptionController.text.toString();
            widget.notesModel.save();
            Navigator.pop(context);
          },
          child: const Text("Edit"),
        ),
      ],
    );
  }
}
