import 'package:flutter/material.dart';

class FileUploadArea extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;
  final String? fileName;

  const FileUploadArea({
    Key? key,
    required this.onTap,
    required this.isLoading,
    this.fileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD1D5DB),
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFFAFBFC),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              CircularProgressIndicator(
                color: Color(0xFF2C2C2C),
                strokeWidth: 2,
              ),
              SizedBox(height: 16),
              Text(
                'Processing file...',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ] else if (fileName != null) ...[
              Icon(
                Icons.check_circle,
                size: 48,
                color: Colors.green,
              ),
              SizedBox(height: 12),
              Text(
                fileName!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2C2C2C),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'File uploaded successfully',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ] else ...[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Upload Excel File',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2C2C),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Click to browse and upload your employee data file (.xlsx, .xls)',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
