import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/employee.dart';
import '../services/api_service.dart';
import '../widgets/file_upload_area.dart';
import '../widgets/employee_pdf_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employee> employees = [];
  bool isLoadingFile = false;
  bool isGeneratingPdfs = false;
  String? selectedFileName;
  Map<int, String> generatedPdfs = {};

  Future<void> uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null) {
        setState(() {
          isLoadingFile = true;
          selectedFileName = result.files.single.name;
        });

        // Parse the Excel file
        final employeeList = await ApiService.parseExcelFile(result.files.single.path!);
        
        setState(() {
          employees = employeeList;
          isLoadingFile = false;
          generatedPdfs.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Excel file loaded successfully! ${employees.length} employees found.'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoadingFile = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading file: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> generateAllPdfs() async {
    if (employees.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload an Excel file first'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      isGeneratingPdfs = true;
    });

    try {
      await ApiService.generateAllPayslips(employees);
      
      // Generate PDFs for each employee
      for (var employee in employees) {
        final pdfUrl = await ApiService.downloadPayslip(employee.id);
        setState(() {
          generatedPdfs[employee.id] = pdfUrl;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All payslips generated successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating PDFs: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
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
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Payslip Generator'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File Upload Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  FileUploadArea(
                    onTap: uploadFile,
                    isLoading: isLoadingFile,
                    fileName: selectedFileName,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isGeneratingPdfs ? null : generateAllPdfs,
                      child: isGeneratingPdfs
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Generating PDFs...'),
                              ],
                            )
                          : Text(
                              'Generate All PDFs',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            // Generated PDFs Section
            if (employees.isNotEmpty) ...[
              SizedBox(height: 32),
              Text(
                'Generated PDFs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2C2C),
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  final pdfUrl = generatedPdfs[employee.id];
                  
                  return EmployeePdfCard(
                    employee: employee,
                    pdfUrl: pdfUrl,
                    onDownload: () async {
                      if (pdfUrl != null) {
                        final uri = Uri.parse(pdfUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      }
                    },
                  );
                },
              ),
            ],

            if (employees.isEmpty && selectedFileName == null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(48),
                child: Column(
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      size: 64,
                      color: Color(0xFF9CA3AF),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Upload an Excel file to get started',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
