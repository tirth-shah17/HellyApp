import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class ApiService {
  static const String baseUrl = 'https://backend-helly.onrender.com';

  /// Uploads an Excel file and returns a List<Employee> from JSON list.
  static Future<List<Employee>> uploadExcelAndGetPdfLinks(String filePath,String month,String years,String fullDate) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/generate-pdfs/'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    request.fields['month'] = month;
    request.fields['year'] = years;
    request.fields['date'] = fullDate;


    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      final jsonStr = await streamedResponse.stream.bytesToString();

      // The response is a plain list of employees
      final List<dynamic> jsonList = jsonDecode(jsonStr);

      return jsonList
          .map((entry) => Employee.fromJson(entry as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Failed to generate payslips. Status: ${streamedResponse.statusCode}',
      );
    }
  }
}
