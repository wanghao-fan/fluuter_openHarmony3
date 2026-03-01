import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountdownTimerComponent extends StatefulWidget {
  const CountdownTimerComponent({super.key});

  @override
  State<CountdownTimerComponent> createState() => _CountdownTimerComponentState();
}

class _CountdownTimerComponentState extends State<CountdownTimerComponent> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );

  final TextEditingController _durationController = TextEditingController(text: '60');
  int _duration = 60; // 默认60秒
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.setPresetTime(mSec: _duration * 1000);
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
    _stopWatchTimer.onStartTimer();
  }

  void _pauseCountdown() {
    setState(() {
      _isPaused = true;
    });
    _stopWatchTimer.onStopTimer();
  }

  void _resumeCountdown() {
    setState(() {
      _isPaused = false;
    });
    _stopWatchTimer.onStartTimer();
  }

  void _resetCountdown() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });
    _stopWatchTimer.setPresetTime(mSec: _duration * 1000);
    _stopWatchTimer.onResetTimer();
  }

  void _updateDuration() {
    final value = int.tryParse(_durationController.text);
    if (value != null && value > 0) {
      setState(() {
        _duration = value;
      });
      _stopWatchTimer.setPresetTime(mSec: _duration * 1000);
      _stopWatchTimer.onResetTimer();
      setState(() {
        _isRunning = false;
        _isPaused = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '倒计时器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 30),

              // 倒计时显示
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _duration * 1000,
                builder: (context, snapshot) {
                  final value = snapshot.data!;
                  final displayTime = StopWatchTimer.getDisplayTime(value,
                      hours: false,
                      minute: true,
                      second: true,
                      milliSecond: false);
                  return Text(
                    displayTime,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // 时长设置
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '时长（秒）：',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // 实时更新时长
                        final intValue = int.tryParse(value);
                        if (intValue != null && intValue > 0) {
                          _duration = intValue;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _updateDuration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('设置'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 控制按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isRunning)
                    ElevatedButton(
                      onPressed: _startCountdown,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        '开始',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (_isRunning && !_isPaused)
                    ElevatedButton(
                      onPressed: _pauseCountdown,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        '暂停',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (_isPaused)
                    ElevatedButton(
                      onPressed: _resumeCountdown,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        '继续',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _resetCountdown,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      '重置',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 状态提示
              Text(
                _isRunning
                    ? _isPaused
                        ? '已暂停'
                        : '倒计时中...'
                    : '准备就绪',
                style: TextStyle(
                  fontSize: 16,
                  color: _isRunning
                      ? _isPaused
                          ? Colors.orange
                          : Colors.green
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 示例时长
              const Text(
                '常用时长：',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildDurationChip('10秒', 10),
                  _buildDurationChip('30秒', 30),
                  _buildDurationChip('60秒', 60),
                  _buildDurationChip('120秒', 120),
                  _buildDurationChip('300秒', 300),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建时长选择芯片
  Widget _buildDurationChip(String label, int seconds) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _duration = seconds;
          _durationController.text = seconds.toString();
          _stopWatchTimer.setPresetTime(mSec: seconds * 1000);
          _stopWatchTimer.onResetTimer();
          _isRunning = false;
          _isPaused = false;
        });
      },
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.blue[100],
      ),
    );
  }
}
