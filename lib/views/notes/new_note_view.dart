import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/crud/notes_services.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({Key? key}) : super(key: key);

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  DatabaseNote? _note;
  NotesServices? _notesServices;
  TextEditingController? _textController;

  @override
  void initstate() {
    _notesServices = NotesServices();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListner() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController!.text;
    await _notesServices!.updateNote(
      note: note,
      text: text,
    );
  }

  void _setupTextControllerListner() async {
    _textController!.removeListener(_textControllerListner);
    _textController!.addListener(_textControllerListner);
  }

  Future<DatabaseNote?> creatNewNote() async {
    final existinNote = _note;
    if (existinNote != null) {
      return existinNote;
    }
    final currentUser = FirebaseAuth.instance.currentUser!;
    final email = currentUser.email;
    final owner = await _notesServices!.getUser(email: email!);
    return await _notesServices!.createNote(owner: owner);
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController!.text.isEmpty && note != null) {
      _notesServices!.deleteNote(id: note.id.toString());
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController!.text;
    if (note != null && text.isNotEmpty) {
      await _notesServices!.updateNote(
        note: note,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: FutureBuilder(
        future: creatNewNote(),
        builder: (context, sanpshot) {
          switch (sanpshot.connectionState) {
            case ConnectionState.done:
              _note = sanpshot.data as DatabaseNote?;
              _setupTextControllerListner();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Start typing ypur note ...'),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
