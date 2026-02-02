import 'package:flutter/material.dart';

/// 权限类型枚举
enum PermissionType {
  camera,      // 相机权限
  microphone,  // 麦克风权限
  location,    // 位置权限
  storage,     // 存储权限
  contacts,    // 联系人权限
}

/// 权限状态枚举
enum PermissionStatus {
  granted,     // 已授权
  denied,      // 已拒绝
  requested,   // 已请求但未响应
}

/// 权限申请弹窗组件
class PermissionDialog extends StatefulWidget {
  final PermissionType permissionType;
  final String title;
  final String message;
  final String grantButtonText;
  final String denyButtonText;
  final Function(bool)? onPermissionResult;
  final bool barrierDismissible;

  const PermissionDialog({
    Key? key,
    required this.permissionType,
    this.title = '权限申请',
    this.message = '应用需要获取相关权限以提供更好的服务',
    this.grantButtonText = '授予权限',
    this.denyButtonText = '拒绝',
    this.onPermissionResult,
    this.barrierDismissible = true,
  }) : super(key: key);

  @override
  State<PermissionDialog> createState() => _PermissionDialogState();
}

class _PermissionDialogState extends State<PermissionDialog> {
  PermissionStatus _status = PermissionStatus.requested;
  bool _isProcessing = false;

  /// 获取权限图标
  IconData _getPermissionIcon() {
    switch (widget.permissionType) {
      case PermissionType.camera:
        return Icons.camera_alt;
      case PermissionType.microphone:
        return Icons.mic;
      case PermissionType.location:
        return Icons.location_on;
      case PermissionType.storage:
        return Icons.storage;
      case PermissionType.contacts:
        return Icons.contacts;
      default:
        return Icons.info;
    }
  }

  /// 获取权限名称
  String _getPermissionName() {
    switch (widget.permissionType) {
      case PermissionType.camera:
        return '相机';
      case PermissionType.microphone:
        return '麦克风';
      case PermissionType.location:
        return '位置';
      case PermissionType.storage:
        return '存储';
      case PermissionType.contacts:
        return '联系人';
      default:
        return '未知';
    }
  }

  /// 模拟权限申请
  Future<void> _requestPermission() async {
    setState(() {
      _isProcessing = true;
    });

    // 模拟权限申请过程
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _status = PermissionStatus.granted;
      _isProcessing = false;
    });

    // 通知权限申请结果
    if (widget.onPermissionResult != null) {
      widget.onPermissionResult!(true);
    }

    // 延迟关闭弹窗
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  /// 拒绝权限
  void _denyPermission() {
    setState(() {
      _status = PermissionStatus.denied;
    });

    // 通知权限申请结果
    if (widget.onPermissionResult != null) {
      widget.onPermissionResult!(false);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 权限图标
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _status == PermissionStatus.granted
                      ? Colors.green.shade100
                      : _status == PermissionStatus.denied
                          ? Colors.red.shade100
                          : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  _status == PermissionStatus.granted
                      ? Icons.check
                      : _status == PermissionStatus.denied
                          ? Icons.close
                          : _getPermissionIcon(),
                  size: 40,
                  color: _status == PermissionStatus.granted
                      ? Colors.green
                      : _status == PermissionStatus.denied
                          ? Colors.red
                          : Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // 标题
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),

            // 消息
            Text(
              _status == PermissionStatus.granted
                  ? '已成功获取${_getPermissionName()}权限'
                  : _status == PermissionStatus.denied
                      ? '已拒绝${_getPermissionName()}权限'
                      : widget.message,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),

            // 按钮
            if (_status == PermissionStatus.requested) ...[
              Row(
                children: [
                  // 拒绝按钮
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isProcessing ? null : _denyPermission,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        widget.denyButtonText,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),

                  // 授予按钮
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _requestPermission,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              widget.grantButtonText,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 权限申请展示组件（用于直接在页面上显示权限申请效果）
class PermissionRequestDisplay extends StatefulWidget {
  final PermissionType permissionType;
  final String title;
  final String description;

  const PermissionRequestDisplay({
    Key? key,
    required this.permissionType,
    this.title = '权限申请示例',
    this.description = '展示权限申请弹窗效果',
  }) : super(key: key);

  @override
  State<PermissionRequestDisplay> createState() => _PermissionRequestDisplayState();
}

class _PermissionRequestDisplayState extends State<PermissionRequestDisplay> {
  bool _permissionGranted = false;

  /// 显示权限申请弹窗
  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionDialog(
        permissionType: widget.permissionType,
        title: '权限申请',
        message: '应用需要获取${_getPermissionName()}权限以提供更好的服务',
        onPermissionResult: (granted) {
          setState(() {
            _permissionGranted = granted;
          });

          // 显示权限申请结果
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                granted
                    ? '已成功获取${_getPermissionName()}权限'
                    : '已拒绝${_getPermissionName()}权限',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  /// 获取权限名称
  String _getPermissionName() {
    switch (widget.permissionType) {
      case PermissionType.camera:
        return '相机';
      case PermissionType.microphone:
        return '麦克风';
      case PermissionType.location:
        return '位置';
      case PermissionType.storage:
        return '存储';
      case PermissionType.contacts:
        return '联系人';
      default:
        return '未知';
    }
  }

  /// 获取权限图标
  IconData _getPermissionIcon() {
    switch (widget.permissionType) {
      case PermissionType.camera:
        return Icons.camera_alt;
      case PermissionType.microphone:
        return Icons.mic;
      case PermissionType.location:
        return Icons.location_on;
      case PermissionType.storage:
        return Icons.storage;
      case PermissionType.contacts:
        return Icons.contacts;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 权限图标
          Icon(
            _getPermissionIcon(),
            size: 48,
            color: _permissionGranted ? Colors.green : Colors.blue,
          ),
          const SizedBox(height: 16.0),

          // 标题
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),

          // 描述
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),

          // 权限状态
          Text(
            _permissionGranted
                ? '状态：已授权'
                : '状态：未授权',
            style: TextStyle(
              fontSize: 14.0,
              color: _permissionGranted ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(height: 24.0),

          // 申请按钮
          ElevatedButton(
            onPressed: _showPermissionDialog,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('申请${_getPermissionName()}权限'),
          ),
        ],
      ),
    );
  }
}