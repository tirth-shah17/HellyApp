import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/employee.dart';

class ApiService {
  // Replace with your actual backend URL when hosted
  static const String baseUrl = 'http://localhost:5000'; // For local testing
  // static const String baseUrl = 'https://your-app.onrender.com'; // For production
  
  static Future<List<Employee>> parseExcelFile(String filePath) async {
    try {
      // For testing - replace with actual file parsing when backend is ready
      await Future.delayed(Duration(seconds: 2));
      return [
        Employee(id: 4, name: 'Harshi Shah', salary: 16000),
        Employee(id: 5, name: 'Tirth Shah', salary: 20000),
        Employee(id: 6, name: 'John Doe', salary: 25000),
        Employee(id: 7, name: 'Jane Smith', salary: 22000),
      ];
    } catch (e) {
      throw Exception('Error parsing Excel file: $e');
    }
  }

  static Future<bool> generateAllPayslips(List<Employee> employees) async {
    try {
      // Replace with actual API call to your backend
      await Future.delayed(Duration(seconds: 3)); 
      return true;
    } catch (e) {
      throw Exception('Error generating payslips: $e');
    }
  }

  static Future<String> downloadPayslip(int empId) async {
    try {
      // Replace with actual backend URL when ready
      await Future.delayed(Duration(milliseconds: 500));
      return '$baseUrl/payslip/$empId';
    } catch (e) {
      throw Exception('Error downloading payslip: $e');
    }
  }
}
