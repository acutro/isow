import 'package:http/http.dart' as http;
import 'dart:convert';
import '../ApiUtils/apiUtils.dart';
import '../Models/notepadModel.dart';

class TaskService {
  bool error = false;
  bool loading = true;
  var notepad;
  bool notepadDetailserror = false;
  bool notepadetailsloading = true;

  Future<void> getTask(dynamic input) async {
    try {
      notepadDetailserror = false;

      // print(ApiUtils.familyDetailsApi + 'id=VFamily01');
      // make the request
      http.Response response = await http.post(ApiUtils.notepadApi,
          body: input, headers: {'Content-type': 'application/json'});

      Map data = jsonDecode(response.body);
      if (data["Status"] == true) {
        notepad = data["Data"];
        notepad = notepad.map((_data) {
          return new TaskModel.fromJson(_data);
        }).toList();
        print(notepad);
        notepadetailsloading = false;
      } else {
        throw data;
      }
    } catch (e) {
      print(e);
      notepadDetailserror = false;
      notepadetailsloading = true;
    }
  }
}
