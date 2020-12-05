import 'package:e_garden/application.dart';
import 'package:e_garden/core/models/notes/notes.dart';
import 'package:e_garden/utils/exception.dart';
import 'package:flutter/cupertino.dart';

class NoteModel extends ChangeNotifier {
  Notes _listNote;
  Note _noteDetail;

  Notes get listNote => _listNote;
  Map<String, dynamic> _params = null;

  set listNote(Notes value) {
    _listNote = value;
  }

  Map<String, dynamic> get params => _params;

  Note get noteDetail => _noteDetail;

  set noteDetail(Note value) {
    _noteDetail = value;
  }

  set params(Map<String, dynamic> value) {
    _params = value;
    notifyListeners();
  }

  Future<Notes> fetchListNote(Map<String, dynamic> params) async {
    final response = await Application.api
        .get("api/services/app/UserNote/GetListNoteByUser", params);
    print(params);
    if (response.statusCode == 200) {
      _listNote =
          await Notes.fromJson(response.data['result'] as Map<String, dynamic>);
      print(_listNote.items.toString());
      return _listNote;
    } else {
      throw NetworkException(
          message: Map<String, dynamic>.from(
              response.data["error"] as Map<dynamic, dynamic>));
    }
  }

  Future<bool> createNote(Map<String, dynamic> data) async {
    Map<String, dynamic> params = {
      "userId": Application.sharePreference.getInt('userId'),
      "date": "2020-12-05T13:14:45.167Z",
      "titleNote": "string",
      "detailNote": "string",
      "status": true,
      "hexcode": "string",
      "id": 0
    };
    final response = await Application.api
        .post("api/services/app/UserNote/GetListNoteByUser", params);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw NetworkException(
          message: Map<String, dynamic>.from(
              response.data["error"] as Map<dynamic, dynamic>));
    }
  }

  Future<Note> fetchNoteDetail(int noteId) async {
    if (noteId != 0) {
      final response = await Application.api
          .get("api/services/app/UserNote/GetDetailNote", {"noteId": noteId});
      print(params);
      if (response.statusCode == 200) {
        _noteDetail = await Note.fromJson(
            response.data['result'] as Map<String, dynamic>);
        print(_listNote.items.toString());
        return _noteDetail;
      } else {
        throw NetworkException(
            message: Map<String, dynamic>.from(
                response.data["error"] as Map<dynamic, dynamic>));
      }
    }
    return null;
  }
}
