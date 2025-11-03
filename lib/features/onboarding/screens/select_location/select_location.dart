import 'package:flutter/material.dart';
import 'package:softvence_task/common_widget/alarm_Box/alarm_box.dart';
import 'package:softvence_task/constant/app_colors.dart';
import 'package:softvence_task/helper/notification_service/notification_service.dart';

class Alarm {
  final int id;
  final DateTime dateTime;
  bool isActive;

  Alarm({required this.id, required this.dateTime, this.isActive = true});
}

class SelectLocation extends StatefulWidget {
  final String initialLocation;
  const SelectLocation({super.key, required this.initialLocation});

  @override
  State<SelectLocation> createState() => SelectLocationState();
}

class SelectLocationState extends State<SelectLocation> {
  final TextEditingController _locationController = TextEditingController();
  final List<Alarm> _alarms = [];
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _locationController.text = widget.initialLocation;

    _alarms.addAll([
      Alarm(id: 1, dateTime: DateTime(2024, 1, 15, 6, 30), isActive: true),
      Alarm(id: 2, dateTime: DateTime(2024, 1, 15, 8, 0), isActive: false),
      Alarm(id: 3, dateTime: DateTime(2024, 1, 15, 10, 15), isActive: true),
    ]);

    _alarms.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  Future<void> _pickDateTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (pickedTime == null) return;

    if (!mounted) return;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return;

    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (finalDateTime.isBefore(DateTime.now())) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a future date and time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int newId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    Alarm newAlarm = Alarm(id: newId, dateTime: finalDateTime);

    await _notificationService.scheduleAlarm(
      newId,
      finalDateTime,
      _locationController.text.trim(),
    );

    setState(() {
      _alarms.add(newAlarm);
      _alarms.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    });
  }

  void _handleAlarmToggle(Alarm alarm, bool value) {
    setState(() {
      alarm.isActive = value;
    });

    if (value) {
      _notificationService.scheduleAlarm(
        alarm.id,
        alarm.dateTime,
        _locationController.text.trim(),
      );
    } else {
      _notificationService.cancelAlarm(alarm.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Selected Location",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstants.beginColor,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConstants.beginColor, ColorConstants.endColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0XFF211A46),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextField(
                  controller: _locationController,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ColorConstants.beginColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ColorConstants.beginColor,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/images/location_logo.png",
                        height: 20,
                        width: 20,
                        color: Colors.white70,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),
                    hintText: 'Add your location',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0XFF4C4866),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Alarm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _alarms.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final alarm = _alarms[index];
                  return AlarmBox(
                    dateTime: alarm.dateTime,
                    isActive: alarm.isActive,
                    onToggle: (value) => _handleAlarmToggle(alarm, value),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, -90),
        child: FloatingActionButton(
          onPressed: () async {
            await _pickDateTime();
          },
          backgroundColor: const Color(0XFF211A46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}