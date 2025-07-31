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
  String? selectedFilePath;
  bool isLoadingFile = false;
  bool isGeneratingZip = false;
  String? savedZipPath;

  Future<void> pickExcelFile() async {
    try {
      setState(() {
        isLoadingFile = true;
        savedZipPath = null;
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
    setState(() { isGeneratingZip = true; savedZipPath = null; });
    try {
      final zipPath = await ApiService.uploadExcelAndGetZip(selectedFilePath!);
      setState(() { savedZipPath = zipPath; });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payslips ZIP saved to: $zipPath'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() { isGeneratingZip = false; });
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
                  onPressed: isGeneratingZip ? null : () async { await generatePdfs(); },
                  child: isGeneratingZip
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
            if (savedZipPath != null) ...[
              const SizedBox(height: 32),
              Text(
                "Payslips ZIP saved to:\n$savedZipPath",
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
