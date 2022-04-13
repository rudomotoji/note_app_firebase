import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app_firebase/styles/app_style.dart';

class NoteRender extends StatefulWidget {
  const NoteRender({
    Key? key,
    required this.doc,
  }) : super(key: key);

  final QueryDocumentSnapshot doc;

  @override
  State<NoteRender> createState() => _NoteRenderState();
}

class _NoteRenderState extends State<NoteRender> {
  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColor[colorId],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc['note_title'],
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 4),
            Text(
              widget.doc['creation_date'],
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 28),
            Text(
              widget.doc['note_content'],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
