import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://backend-helly.onrender.com';

  static Future<String?> uploadExcelAndGetZip(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/generate-pdfs/'));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();

    if (response.statusCode == 200) {
      var bytes = await response.stream.toBytes();

      final filename = 'payslips_${DateTime.now().millisecondsSinceEpoch}.zip';
      final file = File('/storage/emulated/0/Download/$filename');
      await file.writeAsBytes(bytes);
      return file.path;
    } else {
      throw Exception('Failed to generate payslips. Status: ${response.statusCode}');
    }
  }
}
