import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app_firebase/styles/app_style.dart';
import 'package:intl/intl.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  String date =
      DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()).toString();
  int colorId = Random().nextInt(AppStyle.cardColor.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColor[colorId],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add a new note',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 8),
            Text(date),
            const SizedBox(height: 28),
            TextField(
              controller: _mainController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainContent,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          await FirebaseFirestore.instance.collection('Notes').add({
            'color_id': colorId,
            'note_title': _titleController.text,
            'creation_date': date,
            'note_content': _mainController.text
          }).then((value) {
            print('id note: ${value.id}');
            Navigator.pop(context);
          }).catchError((error) => print('fail to create new note: $error'));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
