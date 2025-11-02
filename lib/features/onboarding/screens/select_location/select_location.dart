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
  }

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2101),
    );

    if (pickedDate == null || !mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (pickedTime == null) return;

    final DateTime finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (finalDateTime.isBefore(DateTime.now())) return;

    int newId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    Alarm newAlarm = Alarm(id: newId, dateTime: finalDateTime);

    await _notificationService.scheduleAlarm(
      newId,
      finalDateTime,
      _locationController.text.trim(),
    );

    setState(() {
      _alarms.add(newAlarm);
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
              _alarms.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          "No alarms set. Tap '+' to add one.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                  : ListView.separated(
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
          onPressed: _pickDateTime,
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
