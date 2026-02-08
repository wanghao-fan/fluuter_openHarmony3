import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileItem {
  final String name;
  final String path;
  final FileSystemEntityType type;
  final DateTime lastModified;
  final int? size;

  FileItem({
    required this.name,
    required this.path,
    required this.type,
    required this.lastModified,
    this.size,
  });
}

class FileListViewer extends StatefulWidget {
  const FileListViewer({Key? key}) : super(key: key);

  @override
  State<FileListViewer> createState() => _FileListViewerState();
}

class _FileListViewerState extends State<FileListViewer> {
  List<FileItem> _fileList = [];
  String _currentPath = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDefaultDirectory();
  }

  Future<void> _loadDefaultDirectory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      await _loadDirectory(directory.path);
    } catch (e) {
      print('Error loading directory: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDirectory(String path) async {
    setState(() {
      _isLoading = true;
      _currentPath = path;
    });

    try {
      final directory = Directory(path);
      final entities = directory.listSync();
      
      final items = entities.map((entity) {
        final fileStat = entity.statSync();
        final type = entity is Directory ? FileSystemEntityType.directory : FileSystemEntityType.file;
        
        return FileItem(
          name: entity.path.split('/').last,
          path: entity.path,
          type: type,
          lastModified: fileStat.modified,
          size: type == FileSystemEntityType.file ? fileStat.size : null,
        );
      }).toList();

      setState(() {
        _fileList = items;
      });
    } catch (e) {
      print('Error loading directory: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickDirectory() async {
    try {
      final result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        await _loadDirectory(result);
      }
    } catch (e) {
      print('Error picking directory: $e');
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );
      
      if (result != null) {
        final pickedFiles = result.files.map((file) {
          final fileStat = File(file.path!).statSync();
          
          return FileItem(
            name: file.name,
            path: file.path!,
            type: FileSystemEntityType.file,
            lastModified: fileStat.modified,
            size: fileStat.size,
          );
        }).toList();

        setState(() {
          _fileList = pickedFiles;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  void _onFileTap(FileItem item) {
    if (item.type == FileSystemEntityType.directory) {
      _loadDirectory(item.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('文件: ${item.name}，大小: ${_formatFileSize(item.size!)}')),
      );
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toolbar
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _currentPath,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _pickDirectory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                child: Text('选择目录'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                child: Text('选择文件'),
              ),
            ],
          ),
        ),

        // File list
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _fileList.isEmpty
                  ? Center(child: Text('无文件'))
                  : ListView.builder(
                      itemCount: _fileList.length,
                      itemBuilder: (context, index) {
                        final item = _fileList[index];
                        
                        return InkWell(
                          onTap: () => _onFileTap(item),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                            ),
                            child: Row(
                              children: [
                                // Icon
                                Icon(
                                  item.type == FileSystemEntityType.directory
                                      ? Icons.folder
                                      : Icons.insert_drive_file,
                                  color: item.type == FileSystemEntityType.directory
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 32,
                                ),
                                SizedBox(width: 16),
                                
                                // File info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${item.type == FileSystemEntityType.directory ? '目录' : _formatFileSize(item.size!)} · ${item.lastModified.toString().substring(0, 10)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Arrow for directories
                                if (item.type == FileSystemEntityType.directory)
                                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

class FileListViewerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FileListViewer(),
    );
  }
}
