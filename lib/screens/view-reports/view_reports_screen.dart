import 'package:abans_city_clean_supervisor/constants/color_pallettee.dart';
import 'package:abans_city_clean_supervisor/models/reports.dart';
import 'package:abans_city_clean_supervisor/screens/fitst_screen.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class ViewReportsScreen extends StatefulWidget {
  @override
  _ViewReportsScreenState createState() => _ViewReportsScreenState();
}

class _ViewReportsScreenState extends State<ViewReportsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<ReportData> dailyReports = [];
  List<ReportData> weeklyReports = [];
  List<ReportData> monthlyReports = [];
  List<ComplaintSummary> complaintSummary = [];
  List<ZonePerformance> zonePerformance = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadReportsData();
  }

  Future<void> _loadReportsData() async {
    await _parseJsonData();
  }

  Future<void> _parseJsonData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/json/reports.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);

    setState(() {
      dailyReports = (jsonData['daily_reports'] as List)
          .map((report) => ReportData.fromJson(report))
          .toList();

      weeklyReports = (jsonData['weekly_reports'] as List)
          .map((report) => ReportData.fromJson(report))
          .toList();

      monthlyReports = (jsonData['monthly_reports'] as List)
          .map((report) => ReportData.fromJson(report))
          .toList();

      complaintSummary = (jsonData['complaint_summary'] as List)
          .map((complaint) => ComplaintSummary.fromJson(complaint))
          .toList();

      zonePerformance = (jsonData['zone_performance'] as List)
          .map((zone) => ZonePerformance.fromJson(zone))
          .toList();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6A1B9A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'View Reports',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
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
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDailyReportsView(),
              _buildWeeklyReportsView(),
              _buildMonthlyReportsView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyReportsView() {
    if (dailyReports.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final report = dailyReports.first;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(report.title, report.period),
          SizedBox(height: 16),
          _buildMetricsGridFromReport(report.metrics),
          SizedBox(height: 24),
          _buildPieChart(report.chartData),
        ],
      ),
    );
  }

  Widget _buildWeeklyReportsView() {
    if (weeklyReports.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final report = weeklyReports.first;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(report.title, report.period),
          SizedBox(height: 16),
          _buildMetricsGridFromReport(report.metrics),
          SizedBox(height: 24),
          _buildWeeklyChartFromData(report.chartData),
        ],
      ),
    );
  }

  Widget _buildMonthlyReportsView() {
    if (monthlyReports.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final report = monthlyReports.first;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(report.title, report.period),
          SizedBox(height: 16),
          _buildMetricsGridFromReport(report.metrics),
          SizedBox(height: 24),
          _buildMonthlyChartFromData(report.chartData),
          SizedBox(height: 24),
          _buildZonePerformanceFromData(),
        ],
      ),
    );
  }

  Widget _buildReportHeader(String title, String period) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              // color: Color(0xFF7B2CBF),
            ),
          ),
          SizedBox(height: 4),
          Text(
            period,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildMetricsGrid(List<Widget> metrics) {
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     crossAxisSpacing: 12,
  //     mainAxisSpacing: 12,
  //     childAspectRatio: 1.2,
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     children: metrics,
  //   );
  // }

  // Widget _buildMetricCard(String label, String value, String unit,
  //     IconData icon, Color color, String trend, double percentage) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.1),
  //           spreadRadius: 1,
  //           blurRadius: 4,
  //           offset: Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Icon(icon, color: color, size: 24),
  //             _buildTrendIndicator(trend, percentage),
  //           ],
  //         ),
  //         SizedBox(height: 12),
  //         Text(
  //           value,
  //           style: TextStyle(
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //             color: color,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 12,
  //             color: Colors.grey[600],
  //           ),
  //         ),
  //         Text(
  //           unit,
  //           style: TextStyle(
  //             fontSize: 10,
  //             color: Colors.grey[500],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTrendIndicator(String trend, double percentage) {
    IconData trendIcon;
    Color trendColor;

    switch (trend) {
      case 'up':
        trendIcon = Icons.trending_up;
        trendColor = Colors.green;
        break;
      case 'down':
        trendIcon = Icons.trending_down;
        trendColor = Colors.red;
        break;
      default:
        trendIcon = Icons.trending_flat;
        trendColor = Colors.grey;
    }

    return Row(
      children: [
        Icon(trendIcon, color: trendColor, size: 16),
        SizedBox(width: 4),
        Text(
          '${percentage.abs()}%',
          style: TextStyle(
            fontSize: 12,
            color: trendColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart(List<ChartData> data) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Collection Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B2CBF),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: data.map((item) {
                  return PieChartSectionData(
                    color: item.color,
                    value: item.value,
                    title: '${item.value.toInt()}',
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildChartLegend(data),
        ],
      ),
    );
  }

  Widget _buildChartLegend(List<ChartData> data) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: data.map((item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 4),
            Text(
              item.label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildMetricsGridFromReport(List<ReportMetric> metrics) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children:
          metrics.map((metric) => _buildMetricCardFromData(metric)).toList(),
    );
  }

  Widget _buildMetricCardFromData(ReportMetric metric) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(metric.icon, color: iconColorDahsbaord2, size: 24),
              _buildTrendIndicator(metric.trend, metric.percentage),
            ],
          ),
          SizedBox(height: 10),
          Text(
            metric.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // color: metric.color,
              color: Color(0xFF6A1B9A),
            ),
          ),
          SizedBox(height: 6),
          Text(
            metric.label,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 2),
          Text(
            metric.unit,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChartFromData(List<ChartData> chartData) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Collections',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B2CBF),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: chartData
                        .map((e) => e.value)
                        .reduce((a, b) => a > b ? a : b) +
                    10,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          chartData[value.toInt()].label,
                          style: TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: chartData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.value,
                        color: entry.value.color,
                        width: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyChartFromData(List<ChartData> chartData) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Collections',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B2CBF),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: chartData
                        .map((e) => e.value)
                        .reduce((a, b) => a > b ? a : b) +
                    50,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          chartData[value.toInt()].label,
                          style: TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: chartData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.value,
                        color: entry.value.color,
                        width: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZonePerformanceFromData() {
    if (zonePerformance.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zone Performance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B2CBF),
            ),
          ),
          SizedBox(height: 16),
          ...zonePerformance.map((zone) {
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zone.zoneName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Efficiency: ${zone.efficiency}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${zone.activeComplaints} complaints',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.amber[700],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
