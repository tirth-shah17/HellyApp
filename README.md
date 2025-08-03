# 📊 Helly Payslip Generator

> A professional Flutter mobile application for generating and managing employee payslips with beautiful PDF output

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-green.svg)](https://dart.dev)
[![Backend](https://img.shields.io/badge/Backend-FastAPI-red.svg)](https://github.com/yourusername/backend-helly)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE)

## ✨ Features

### 📱 Mobile App Features
- **📁 Excel File Upload**: Upload employee data via beautiful drag-and-drop interface
- **📅 Date Selection**: Choose payroll month, year, and specific dates
- **🎨 Professional PDF Generation**: Generate beautifully designed payslips
- **👀 PDF Preview**: View payslips before sharing
- **📤 One-Click Sharing**: Share payslips directly from the app
- **✅ Status Tracking**: Track which payslips have been shared
- **📱 Cross-Platform**: Works on both Android and iOS

### 💼 Business Features
- **💰 Salary Calculation**: Automatic calculation with deductions and advances
- **🏢 Company Branding**: Professional layout with company logo and details
- **📊 Batch Processing**: Generate multiple payslips simultaneously
- **🔄 Real-time Status**: Live updates on PDF generation progress

## 🖼️ Screenshots

### Main Interface
```
┌─────────────────────────────────────┐
│  🏢 Helly Consultancy Services      │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────────┐ │
│  │         📁 Upload Excel File    │ │
│  │    Click to browse and upload   │ │
│  │    (.xlsx, .xls)               │ │
│  └─────────────────────────────────┘ │
│                                     │
│  📅 Select Date: [DD/MM/YYYY]       │
│                                     │
│  [Generate PDFs]                    │
└─────────────────────────────────────┘
```

### Employee List with Status
```
┌─────────────────────────────────────┐
│  Employee Payslips                  │
├─────────────────────────────────────┤
│  👤 John Doe                        │
│     ID: 101 • Salary: ₹25,000      │
│                          [Shared] 📤│
├─────────────────────────────────────┤
│  👤 Jane Smith                      │
│     ID: 102 • Salary: ₹30,000      │
│                          [Ready] 📄 │
└─────────────────────────────────────┘
```

## 🏗️ Architecture

### System Overview
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Flutter App   │    │   FastAPI       │    │   PDF Engine    │
│                 │    │   Backend       │    │                 │
│ • File Upload   │◄──►│ • Excel Parser  │◄──►│ • FPDF Library  │
│ • UI/UX         │    │ • API Endpoints │    │ • Template Gen  │
│ • PDF Preview   │    │ • File Storage  │    │ • Styling       │
│ • Share Feature │    │ • CORS Config   │    │ • Export        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 ▼
                    ┌─────────────────┐
                    │   Render.com    │
                    │   Deployment    │
                    │                 │
                    │ • Cloud Hosting │
                    │ • Auto Scaling  │
                    │ • SSL Security  │
                    └─────────────────┘
```

### Repository Structure
```
📁 Project Structure:
├── 📱 helly-app/              # Flutter Mobile App (This Repo)
│   ├── lib/
│   │   ├── models/
│   │   ├── screens/
│   │   ├── services/
│   │   └── widgets/
│   └── pubspec.yaml
│
└── 🖥️ backend-helly/          # FastAPI Backend (Separate Repo)
    ├── main.py
    ├── payslip_pdf_generator.py
    └── requirements.txt
```

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.0+)
- Dart (3.0+)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/helly-app.git
   cd helly-app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Backend Setup
The backend runs separately on Render.com. For local development:

1. **Clone backend repository**:
   ```bash
   git clone https://github.com/yourusername/backend-helly.git
   ```

2. **Follow backend setup instructions** in the [backend-helly repository](https://github.com/yourusername/backend-helly)

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── employee.dart           # Employee data model
├── screens/
│   ├── home_page.dart          # Main application screen
│   └── pdf_preview_page.dart   # PDF preview screen
├── services/
│   └── api_service.dart        # Backend API integration
└── widgets/
    ├── employee_pdf_card.dart  # Employee list item widget
    └── file_upload_area.dart   # File upload UI component
```

### Key Components

#### 🏠 HomePage (`home_page.dart`)
- **File Selection**: Excel file picker with validation
- **Date Selection**: Month/year picker with calendar widget
- **PDF Generation**: Batch processing with progress indicators
- **Employee List**: Scrollable list with status tracking

#### 📄 PDF Preview (`pdf_preview_page.dart`)
- **PDF Viewer**: High-quality PDF rendering
- **Navigation**: Full-screen PDF viewing experience

#### 🔌 API Service (`api_service.dart`)
- **File Upload**: Multipart form data handling
- **Error Handling**: Comprehensive error management
- **Response Parsing**: JSON to model conversion

#### 📊 Employee Model (`employee.dart`)
- **Data Structure**: Employee information schema
- **JSON Serialization**: API response mapping
- **State Management**: Sharing status tracking

## 🔧 Configuration

### API Endpoints
```dart
class ApiService {
  static const String baseUrl = 'https://backend-helly.onrender.com';
  
  // Main endpoint for PDF generation
  static Future<List<Employee>> uploadExcelAndGetPdfLinks(
    String filePath,
    String month,
    String year,
    String fullDate
  ) async {
    // Implementation details...
  }
}
```

### Backend Integration
The app communicates with a FastAPI backend that:
- Processes Excel files with employee data
- Generates professional PDF payslips
- Provides download URLs for each payslip
- Handles file storage and temporary management

### Expected Excel Format
```
Row 1-4: Header information (skipped)
Row 5: Column headers
- NAME: Employee name
- SALARY: Base salary amount
- ADVANCE: Advance amount (deduction)
- DEDUCTION: Other deductions
- mobile no: Employee mobile number
- NET: Calculated net salary
```

## 📱 Usage Guide

### Step 1: Upload Excel File
1. Tap the upload area on the home screen
2. Select an Excel file (.xlsx or .xls) with employee data
3. Wait for file validation and processing

### Step 2: Select Date
1. Tap the date field
2. Choose the payroll month and year
3. Select specific pay date using the calendar

### Step 3: Generate Payslips
1. Tap "Generate PDFs" button
2. Wait for batch processing to complete
3. View the list of generated payslips

### Step 4: Preview and Share
1. Tap any employee card to preview their payslip
2. Tap the share button to send the payslip
3. Track sharing status with visual indicators

## 🎨 UI/UX Features

### Design System
- **Modern Material Design**: Clean, professional interface
- **Consistent Color Scheme**: Brand-aligned color palette
- **Responsive Layout**: Adapts to different screen sizes
- **Intuitive Navigation**: User-friendly flow

### Visual Feedback
- **Loading States**: Progress indicators for all async operations
- **Success/Error Messages**: Toast notifications for user actions
- **Status Tracking**: Visual indicators for payslip sharing status
- **Smooth Animations**: Polished transitions and interactions

### Accessibility
- **Screen Reader Support**: Semantic widgets and descriptions
- **High Contrast**: Accessible color combinations
- **Touch Targets**: Appropriately sized interactive elements
- **Error Handling**: Clear error messages and recovery options

## 📋 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  file_picker: ^6.1.1          # File selection
  http: ^1.1.0                 # HTTP requests
  share_plus: ^7.2.1           # Social sharing
  path_provider: ^2.1.1        # File system access
  syncfusion_flutter_pdfviewer: ^23.2.7  # PDF viewing
```

### Key Features by Package
- **file_picker**: Cross-platform file selection with type filtering
- **http**: RESTful API communication with multipart uploads
- **share_plus**: Native sharing across platforms
- **path_provider**: Temporary file storage management
- **syncfusion_flutter_pdfviewer**: High-quality PDF rendering

## 🔒 Security & Privacy

### Data Protection
- **Temporary Storage**: Files are temporarily stored and cleaned up
- **Secure Transmission**: HTTPS communication with backend
- **No Data Persistence**: Employee data is not stored locally
- **Privacy Compliance**: Minimal data collection and processing

### Error Handling
```dart
try {
  final employees = await ApiService.uploadExcelAndGetPdfLinks(
    filePath, month, year, fullDate
  );
  // Success handling
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Error: $e'),
      backgroundColor: Colors.red,
    ),
  );
}
```

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Categories
- **Unit Tests**: Model validation and business logic
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end workflow testing
- **API Tests**: Backend communication testing

## 📦 Build & Deployment

### Android Build
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App Bundle for Play Store
flutter build appbundle --release
```

### iOS Build
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Archive for App Store
flutter build ipa
```

### CI/CD Pipeline
Consider setting up automated builds with:
- **GitHub Actions**: Automated testing and building
- **Fastlane**: App store deployment automation
- **Firebase App Distribution**: Beta testing distribution

## 🔗 Related Repositories

### Backend Repository
🔗 **[backend-helly](https://github.com/yourusername/backend-helly)**
- FastAPI backend service
- PDF generation engine
- Excel file processing
- Deployed on Render.com

### Key Backend Features
- **Excel Processing**: Pandas-based data parsing
- **PDF Generation**: FPDF with professional templates
- **File Management**: Temporary file handling with cleanup
- **CORS Configuration**: Cross-origin request support
- **Cloud Deployment**: Auto-scaling on Render.com

## 🤝 Contributing

### Development Workflow
1. **Fork** both repositories (app and backend)
2. **Create feature branch**: `git checkout -b feature/amazing-feature`
3. **Make changes** with proper testing
4. **Test thoroughly** on multiple devices
5. **Submit pull request** with detailed description

### Code Standards
- **Dart Style Guide**: Follow official Dart conventions
- **Widget Organization**: Separate concerns appropriately
- **Error Handling**: Comprehensive error management
- **Documentation**: Comment complex business logic
- **Testing**: Maintain good test coverage

### Issue Reporting
When reporting issues, include:
- **Device Information**: OS version, device model
- **App Version**: Current app version number
- **Steps to Reproduce**: Detailed reproduction steps
- **Expected vs Actual**: What should happen vs what happens
- **Screenshots**: Visual evidence when applicable

## 🐛 Troubleshooting

### Common Issues

**Q: App crashes when selecting Excel file**
- Ensure the Excel file follows the expected format
- Check file permissions on the device
- Verify the file is not corrupted

**Q: PDF generation fails**
- Check internet connectivity
- Verify backend service is running
- Ensure Excel file has valid employee data

**Q: PDF preview doesn't work**
- Check device storage permissions
- Verify PDF was downloaded successfully
- Restart the app if preview fails

**Q: Sharing doesn't work**
- Grant necessary permissions for sharing
- Ensure target apps are installed
- Check device storage space

### Debug Mode
Enable debug logging by running:
```bash
flutter run --debug
```

Check logs in:
- **Android**: `adb logcat`
- **iOS**: Xcode console
- **Flutter**: `flutter logs`

## 🗺️ Roadmap

### Upcoming Features
- [ ] **Multi-Company Support**: Handle multiple organizations
- [ ] **Template Customization**: Custom payslip designs
- [ ] **Bulk Operations**: Mass actions on employee list
- [ ] **Offline Mode**: Work without internet connectivity
- [ ] **Backup & Sync**: Cloud backup for generated payslips
- [ ] **Analytics Dashboard**: Payroll insights and reports
- [ ] **Multi-Language**: Support for regional languages
- [ ] **Dark Mode**: Dark theme support

### Performance Improvements
- [ ] **Lazy Loading**: Optimize large employee lists
- [ ] **Caching**: Cache frequently accessed data
- [ ] **Image Optimization**: Compress and optimize images
- [ ] **Memory Management**: Optimize memory usage

### Integration Plans
- [ ] **Cloud Storage**: Google Drive, Dropbox integration
- [ ] **Email Integration**: Direct email sending
- [ ] **WhatsApp Business**: Direct WhatsApp sharing
- [ ] **HR Systems**: Integration with popular HR platforms

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Syncfusion** for the excellent PDF viewer
- **FastAPI Team** for the robust backend framework
- **Render.com** for reliable cloud hosting
- **Open Source Community** for inspiration and libraries

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/helly-app/issues)
- **Backend Issues**: [Backend Issues](https://github.com/yourusername/backend-helly/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/helly-app/discussions)
- **Email**: support@hellyconsultancy.com

## 📊 Stats

- **Language**: Dart/Flutter
- **Backend**: Python/FastAPI
- **Platform**: iOS, Android
- **Deployment**: Cloud-based (Render.com)
- **PDF Engine**: FPDF with custom templates

---

<div align="center">

**Built with ❤️ for Helly Consultancy Services**

[⭐ Star this repo](https://github.com/yourusername/helly-app) • [🐛 Report Bug](https://github.com/yourusername/helly-app/issues) • [💡 Request Feature](https://github.com/yourusername/helly-app/issues) • [🔗 Backend Repo](https://github.com/yourusername/backend-helly)

</div>
