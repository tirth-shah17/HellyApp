import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeePdfCard extends StatelessWidget {
  final Employee employee;
  final String? pdfUrl;
  final VoidCallback onDownload;

  const EmployeePdfCard({
    Key? key,
    required this.employee,
    this.pdfUrl,
    required this.onDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: employee.isShared ? Colors.green : Color(0xFFE5E7EB),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Employee Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                employee.name.isNotEmpty ? employee.name[0].toUpperCase() : 'E',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ),
          ),
          SizedBox(width: 16),

          // Employee Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C2C2C),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ID: ${employee.id} • Salary: ₹${employee.salary.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          // PDF Status and Share
          if (pdfUrl != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: employee.isShared ? Color(0xFFDCFCE7) : Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: employee.isShared ? Color(0xFF86EFAC) : Color(0xFFBBF7D0),
                ),
              ),
              child: Text(
                employee.isShared ? 'Shared' : 'Ready',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: employee.isShared ? Color(0xFF15803D) : Color(0xFF15803D),
                ),
              ),
            ),
            SizedBox(width: 12),
            IconButton(
              onPressed: onDownload,
              icon: Icon(
                employee.isShared ? Icons.check : Icons.share,
                size: 20,
              ),
              style: IconButton.styleFrom(
                backgroundColor: employee.isShared ? Colors.green : Color(0xFF2C2C2C),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(8),
              ),
            ),
          ] else ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFFFDE047)),
              ),
              child: Text(
                'Pending',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF92400E),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
