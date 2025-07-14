import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';

class ScheduleTemplatesScreen extends StatefulWidget {
  @override
  _ScheduleTemplatesScreenState createState() =>
      _ScheduleTemplatesScreenState();
}

class _ScheduleTemplatesScreenState extends State<ScheduleTemplatesScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Daily',
    'Weekly',
    'Monthly',
    'Custom'
  ];

  // Sample template data
  final List<Map<String, dynamic>> templates = [
    {
      'id': 'TPL001',
      'name': 'Daily Residential Collection',
      'category': 'Daily',
      'description': 'Standard daily collection template for residential areas',
      'frequency': 'Daily',
      'duration': '4 hours',
      'routes': 3,
      'trucks': 2,
      'crews': 6,
      'timeSlots': ['08:00 AM - 12:00 PM', '01:00 PM - 05:00 PM'],
      'usageCount': 15,
      'lastUsed': '2024-01-15',
      'isActive': true,
      'creator': 'Admin',
      'zones': ['North Zone', 'Central Zone'],
    },
    {
      'id': 'TPL002',
      'name': 'Weekly Commercial Collection',
      'category': 'Weekly',
      'description': 'Weekly collection template for commercial districts',
      'frequency': 'Weekly',
      'duration': '6 hours',
      'routes': 2,
      'trucks': 3,
      'crews': 9,
      'timeSlots': ['06:00 AM - 12:00 PM'],
      'usageCount': 8,
      'lastUsed': '2024-01-12',
      'isActive': true,
      'creator': 'Manager',
      'zones': ['Commercial District', 'Industrial Zone'],
    },
    {
      'id': 'TPL003',
      'name': 'Monthly Bulk Waste',
      'category': 'Monthly',
      'description': 'Monthly bulk waste collection template',
      'frequency': 'Monthly',
      'duration': '8 hours',
      'routes': 5,
      'trucks': 4,
      'crews': 12,
      'timeSlots': ['07:00 AM - 03:00 PM'],
      'usageCount': 3,
      'lastUsed': '2024-01-01',
      'isActive': true,
      'creator': 'Supervisor',
      'zones': ['All Zones'],
    },
    {
      'id': 'TPL004',
      'name': 'Holiday Schedule',
      'category': 'Custom',
      'description': 'Special schedule template for holidays',
      'frequency': 'Custom',
      'duration': '2 hours',
      'routes': 1,
      'trucks': 1,
      'crews': 3,
      'timeSlots': ['10:00 AM - 12:00 PM'],
      'usageCount': 5,
      'lastUsed': '2024-01-10',
      'isActive': false,
      'creator': 'Admin',
      'zones': ['Priority Areas'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTemplates = selectedCategory == 'All'
        ? templates
        : templates
            .where((template) => template['category'] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Templates',
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
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showCreateTemplateDialog();
            },
          ),
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
                    Text('About Us', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'contact',
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text('Contact Us', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
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
        child: Column(
          children: [
            // Category Filter
            Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    bool isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryPurpleColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : Color(0xFF7B3F98),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Template Count
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${filteredTemplates.length} Templates',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7B3F98),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.grid_view, color: Color(0xFF7B3F98)),
                        onPressed: () {
                          // Toggle grid view
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.sort, color: Color(0xFF7B3F98)),
                        onPressed: () {
                          // Sort templates
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Templates List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredTemplates.length,
                itemBuilder: (context, index) {
                  final template = filteredTemplates[index];
                  return _buildTemplateCard(template);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryPurpleColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryPurpleColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.content_copy,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              template['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7B3F98),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: template['isActive']
                                  ? Colors.green
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              template['isActive'] ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        template['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        Icons.schedule,
                        template['frequency'],
                        'Frequency',
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        Icons.access_time,
                        template['duration'],
                        'Duration',
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        Icons.trending_up,
                        template['usageCount'].toString(),
                        'Used',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Resources
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resources Required',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7B3F98),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildResourceItem(
                              Icons.route, template['routes'], 'Routes'),
                          _buildResourceItem(Icons.local_shipping,
                              template['trucks'], 'Trucks'),
                          _buildResourceItem(
                              Icons.group, template['crews'], 'Crews'),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Time Slots
                if (template['timeSlots'].isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time Slots',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7B3F98),
                          ),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: template['timeSlots'].map<Widget>((slot) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                slot,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 16),

                // Zones
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coverage Zones',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7B3F98),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        template['zones'].join(', '),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      Icons.visibility,
                      'View',
                      Colors.blue,
                      () => _viewTemplate(template),
                    ),
                    _buildActionButton(
                      Icons.play_arrow,
                      'Use',
                      Colors.green,
                      () => _useTemplate(template),
                    ),
                    _buildActionButton(
                      Icons.edit,
                      'Edit',
                      Colors.orange,
                      () => _editTemplate(template),
                    ),
                    _buildActionButton(
                      Icons.copy,
                      'Clone',
                      Colors.purple,
                      () => _cloneTemplate(template),
                    ),
                    _buildActionButton(
                      Icons.delete,
                      'Delete',
                      Colors.red,
                      () => _deleteTemplate(template),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: primaryPurpleColor, size: 20),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B3F98),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildResourceItem(IconData icon, int count, String label) {
    return Column(
      children: [
        Icon(icon, color: primaryPurpleColor, size: 18),
        SizedBox(height: 4),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7B3F98),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateTemplateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Template'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Template Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: ['Daily', 'Weekly', 'Monthly', 'Custom'].map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  // Handle category change
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Template created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: primaryPurpleColor),
            child: Text('Create', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _viewTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Template Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogDetailItem('Name', template['name']),
              _buildDialogDetailItem('Category', template['category']),
              _buildDialogDetailItem('Description', template['description']),
              _buildDialogDetailItem('Frequency', template['frequency']),
              _buildDialogDetailItem('Duration', template['duration']),
              _buildDialogDetailItem('Routes', template['routes'].toString()),
              _buildDialogDetailItem('Trucks', template['trucks'].toString()),
              _buildDialogDetailItem('Crews', template['crews'].toString()),
              _buildDialogDetailItem(
                  'Usage Count', template['usageCount'].toString()),
              _buildDialogDetailItem('Last Used', template['lastUsed']),
              _buildDialogDetailItem('Creator', template['creator']),
              _buildDialogDetailItem('Zones', template['zones'].join(', ')),
              _buildDialogDetailItem(
                  'Time Slots', template['timeSlots'].join(', ')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF7B3F98),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _useTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Use Template'),
        content: Text(
            'Create a new schedule based on "${template['name']}" template?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Redirecting to create schedule with template...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: primaryPurpleColor),
            child: Text('Use Template', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _editTemplate(Map<String, dynamic> template) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit template functionality to be implemented'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _cloneTemplate(Map<String, dynamic> template) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Template cloned successfully!'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _deleteTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Template'),
        content: Text(
            'Are you sure you want to delete "${template['name']}" template?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Template deleted successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
