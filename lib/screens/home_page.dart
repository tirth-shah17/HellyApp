import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/file_upload_area.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedFileName;
  bool isLoadingFile = false;
  bool isUploading = false;

  Future<void> uploadExcelFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          isLoadingFile = true;
          selectedFileName = result.files.single.name;
        });

        final filePath = result.files.single.path!;
        setState(() {
          isUploading = true;
        });

        final savedZipPath = await ApiService.uploadExcelAndGetZip(filePath);

        if (savedZipPath != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payslips ZIP saved to: $savedZipPath'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
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
      setState(() {
        isUploading = false;
        isLoadingFile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payslip Generator'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Color(0xFFF8F9FA),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            FileUploadArea(
              onTap: uploadExcelFile,
              isLoading: isUploading,
              fileName: selectedFileName,
            ),
          ],
        ),
      ),
    );
  }
}
