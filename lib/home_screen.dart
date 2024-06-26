import 'package:flutter/material.dart';
import 'package:hive_database/Boxes/boxes.dart';
import 'package:hive_database/Models/notes_model.dart';
import 'package:hive_database/Dialog%20Box/dialog_box.dart';
import 'package:hive_database/Dialog%20Box/edit_dialog.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade300,
        centerTitle: true,
        title: const Text(
          "NOTES",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Card(
                      color: Colors.yellow.shade100,
                      shadowColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data[index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        _showEditDialog(
                                          data[index],
                                          data[index].title.toString(),
                                          data[index].discription.toString(),
                                        );
                                      },
                                      child: Icon(Icons.edit,
                                          size: 18,
                                          color: Colors.red.shade300)),
                                  const SizedBox(width: 15),
                                  InkWell(
                                    onTap: () {
                                      delete(data[index]);
                                    },
                                    child: Icon(Icons.delete,
                                        size: 18,
                                        color: Colors.yellow.shade700),
                                  )
                                ],
                              ),
                              Text(
                                data[index].discription.toString(),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ]),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _showEditDialog(
      NotesModel notesModel, String title, String description) async {
    return showDialog(
      context: context,
      builder: (context) {
        return EditNoteDialog(
          notesModel: notesModel,
          title: title,
          description: description,
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AddNoteDialog();
      },
    );
  }
}
