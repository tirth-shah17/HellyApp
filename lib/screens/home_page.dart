import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:payslip_app/models/employee.dart';
import 'package:payslip_app/widgets/employee_pdf_card.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/file_upload_area.dart';
import '../services/api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'pdf_preview_page.dart'; // 👈 Create this file if not already


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedFileName;
  String? selectedFilePath;
  bool isLoadingFile = false;
  bool isGeneratingPdfs = false;
  List<Employee> employees = [];



  Future<void> pickExcelFile() async {
    try {
      setState(() {
        isLoadingFile = true;
      });
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedFileName = result.files.single.name;
          selectedFilePath = result.files.single.path;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File selected: ${result.files.single.name}'),
            backgroundColor: Colors.blueGrey,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() { isLoadingFile = false; });
    }
  }

    Future<void> generatePdfs() async {
    if (selectedFilePath == null) return;

    setState(() {
      isGeneratingPdfs = true;
      employees.clear();
    });

    try {
      final employeeList = await ApiService.uploadExcelAndGetPdfLinks(selectedFilePath!);
      setState(() {
        employees = employeeList;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Generated ${employeeList.length} payslips.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isGeneratingPdfs = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payslip Generator'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Changed from center to top alignment
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- FileUploadArea is always on top in the same place ---
            FileUploadArea(
              onTap: isLoadingFile ? null : () async { await pickExcelFile(); },
              isLoading: isLoadingFile,
              fileName: selectedFileName,
            ),
            const SizedBox(height: 24),
            // --- Show "Generate PDFs" and result only below the upload area ---
            if (selectedFileName != null) ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isGeneratingPdfs ? null : () async { await generatePdfs(); },
                  child: isGeneratingPdfs
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text("Generating PDFs..."),
                          ],
                        )
                      : const Text("Generate PDFs",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
                        if (employees.isNotEmpty) ...[
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return EmployeePdfCard(
  employee: employee,
  pdfUrl: employee.pdfUrl,
  onDownload: () async {
    if (employee.pdfUrl != null) {
      try {
        final fullUrl = 'https://backend-helly.onrender.com${employee.pdfUrl}';
        final response = await http.get(Uri.parse(fullUrl));

        if (response.statusCode == 200) {
          final dir = await getTemporaryDirectory();
          final filePath = '${dir.path}/${employee.name}_${employee.id}.pdf';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          await Share.shareXFiles([XFile(filePath)], text: 'Payslip for ${employee.name}');

          setState(() {
            employee.isShared = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Shared payslip of ${employee.name}!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to download PDF.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  },
  onTap: () async {
    if (employee.pdfUrl != null) {
      final fullUrl = 'https://backend-helly.onrender.com${employee.pdfUrl}';

      try {
        final response = await http.get(Uri.parse(fullUrl));

        if (response.statusCode == 200) {
          final dir = await getTemporaryDirectory();
          final localPath = '${dir.path}/${employee.name}_${employee.id}.pdf';
          final file = File(localPath);
          await file.writeAsBytes(response.bodyBytes);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(filePath: localPath),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch PDF')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading PDF: $e')),
        );
      }
    }
  },
);



    
                  },
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }
}
