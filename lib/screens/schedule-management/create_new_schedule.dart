import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';

class CreateNewScheduleScreen extends StatefulWidget {
  @override
  _CreateNewScheduleScreenState createState() =>
      _CreateNewScheduleScreenState();
}

class _CreateNewScheduleScreenState extends State<CreateNewScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedRoute;
  String? selectedTruck;
  String? selectedDriver;
  List<String> selectedDays = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? scheduleType;

  final List<String> routes = [
    'Route A - North Zone',
    'Route B - Central Zone',
    'Route C - South Zone',
    'Route D - East Zone',
    'Route E - West Zone',
  ];

  final List<String> trucks = [
    'Truck #T-001',
    'Truck #T-003',
    'Truck #T-005',
    'Truck #T-007',
    'Truck #T-009',
    'Truck #T-012',
  ];

  final List<String> drivers = [
    'Ravi Silva',
    'Sunil Perera',
    'Kamal Fernando',
    'Nimal Jayasinghe',
    'Chamara Perera',
    'Mahinda Padmakumara',
  ];

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> scheduleTypes = [
    'Daily Collection',
    'Weekly Collection',
    'Bi-Weekly Collection',
    'Monthly Collection',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Schedule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6A1B9A),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.details, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'contact',
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC107).withOpacity(0.3),
                Color(0xFFFFF8E1),
                Color(0xFFFFFBE6),
                Color(0xFFFFC107).withOpacity(0.3),
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Schedule Type Selection
                  _buildSectionTitle('Schedule Type'),
                  SizedBox(height: 8),
                  _buildDropdownField(
                    label: 'Schedule Type',
                    value: scheduleType,
                    items: scheduleTypes,
                    onChanged: (value) => setState(() => scheduleType = value),
                    icon: Icons.schedule,
                  ),

                  SizedBox(height: 24),

                  // Route Selection
                  _buildSectionTitle('Route Details'),
                  SizedBox(height: 8),
                  _buildDropdownField(
                    label: 'Route',
                    value: selectedRoute,
                    items: routes,
                    onChanged: (value) => setState(() => selectedRoute = value),
                    icon: Icons.route,
                  ),

                  SizedBox(height: 16),

                  // Truck Selection
                  _buildDropdownField(
                    label: 'Truck',
                    value: selectedTruck,
                    items: trucks,
                    onChanged: (value) => setState(() => selectedTruck = value),
                    icon: Icons.local_shipping,
                  ),

                  SizedBox(height: 16),

                  // Driver Selection
                  _buildDropdownField(
                    label: 'Driver',
                    value: selectedDriver,
                    items: drivers,
                    onChanged: (value) =>
                        setState(() => selectedDriver = value),
                    icon: Icons.person,
                  ),

                  SizedBox(height: 24),

                  // Day Selection
                  _buildSectionTitle('Schedule Days'),
                  SizedBox(height: 8),
                  _buildDaySelector(context),

                  SizedBox(height: 24),

                  // Time Selection
                  _buildSectionTitle('Time Schedule'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTimeSelector(
                          label: 'Start Time',
                          time: startTime,
                          onTap: () => _selectTime(context, true),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTimeSelector(
                          label: 'End Time',
                          time: endTime,
                          onTap: () => _selectTime(context, false),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Additional Notes
                  _buildSectionTitle('Additional Notes (Optional)'),
                  SizedBox(height: 8),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Add any special instructions or notes',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                  SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      // Expanded(
                      //   child: OutlinedButton(
                      //     onPressed: () => Navigator.pop(context),
                      //     style: OutlinedButton.styleFrom(
                      //       side: BorderSide(color: Color(0xFF7B3F98)),
                      //       padding: EdgeInsets.symmetric(vertical: 16),
                      //     ),
                      //     child: Text(
                      //       'Cancel',
                      //       style: TextStyle(
                      //         color: Color(0xFF7B3F98),
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _createSchedule,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryPurpleColor,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Create Schedule',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF7B3F98),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF7B3F98)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please $label' : null,
      ),
    );
  }

  Widget _buildDaySelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Collection Days',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7B3F98),
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: days.map((day) {
              bool isSelected = selectedDays.contains(day);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedDays.remove(day);
                    } else {
                      selectedDays.add(day);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF7B3F98) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Color(0xFF7B3F98)),
                SizedBox(width: 8),
                Text(
                  time != null ? time.format(context) : 'Select Time',
                  style: TextStyle(
                    fontSize: 16,
                    // color: time != null ? Color(0xFF7B3F98) : Colors.grey[500],
                    color: time != null ? Colors.black : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (startTime ?? TimeOfDay(hour: 8, minute: 0))
          : (endTime ?? TimeOfDay(hour: 12, minute: 0)),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _createSchedule() {
    if (_formKey.currentState!.validate()) {
      if (selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select at least one day'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (startTime == null || endTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select start and end time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Create schedule logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }
}
