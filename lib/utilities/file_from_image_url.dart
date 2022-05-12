import 'dart:io';
import 'package:academic_calendar/utilities/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File> fileFromImageUrl(String url) async {
  url = await getImage(url);
  final response = await http.get(Uri.parse(url));

  final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, 'imagetest.png'));

  file.writeAsBytesSync(response.bodyBytes);

  return file;
}
