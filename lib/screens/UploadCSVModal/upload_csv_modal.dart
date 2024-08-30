import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/file_services.dart';
import 'package:frontend/services/loader_service.dart';

class CsvUploadContent extends StatefulWidget {
  @override
  _CsvUploadContentState createState() => _CsvUploadContentState();
}

class _CsvUploadContentState extends State<CsvUploadContent> {
  String? _fileName;
  String? _filePath;
  bool _isLoading = false;

  late FileServices _fileServices;
  late AlertService _alertService;

  Future<void> _uploadCsv({required String filepath}) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final response = await _fileServices.uploadCsvFile(filepath);

      if (response != null) {
        _alertService.showSnackBar(message: 'File uploaded successfully.');
      } else {
        _alertService.showSnackBar(message: 'Could not upload file.');
      }
    } catch (_) {
      _alertService.showSnackBar(message: 'Could not upload file.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _pickCsvFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fileServices = FileServices();
    _alertService = AlertService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_fileName != null) Text('Selected file: $_fileName'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickCsvFile,
          child: Text('Select CSV File'),
        ),
        SizedBox(height: 20),
        _filePath != null
            ? ElevatedButton(
                onPressed: () async {
                  await _uploadCsv(filepath: _filePath!);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _isLoading ? CircularProgressIndicator() : Text('Upload'),
                ),
              )
            : Container()
      ],
    );
  }
}
