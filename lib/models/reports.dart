import 'package:flutter/material.dart';

class ReportData {
  final String id;
  final String title;
  final String period;
  final String description;
  final List<ReportMetric> metrics;
  final DateTime generatedDate;
  final String reportType;
  final List<ChartData> chartData;

  ReportData({
    required this.id,
    required this.title,
    required this.period,
    required this.description,
    required this.metrics,
    required this.generatedDate,
    required this.reportType,
    required this.chartData,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      id: json['id'],
      title: json['title'],
      period: json['period'],
      description: json['description'],
      metrics: (json['metrics'] as List)
          .map((metric) => ReportMetric.fromJson(metric))
          .toList(),
      generatedDate: DateTime.parse(json['generated_date']),
      reportType: json['report_type'],
      chartData: (json['chart_data'] as List)
          .map((data) => ChartData.fromJson(data))
          .toList(),
    );
  }
}

class ReportMetric {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final String trend;
  final double percentage;

  ReportMetric({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.trend,
    required this.percentage,
  });

  factory ReportMetric.fromJson(Map<String, dynamic> json) {
    return ReportMetric(
      label: json['label'],
      value: json['value'],
      unit: json['unit'],
      icon: _getIconFromString(json['icon']),
      color: _getColorFromString(json['color']),
      trend: json['trend'],
      percentage: json['percentage'].toDouble(),
    );
  }

  static IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'delete':
        return Icons.delete;
      case 'local_shipping':
        return Icons.local_shipping;
      case 'location_on':
        return Icons.location_on;
      case 'warning':
        return Icons.warning;
      case 'check_circle':
        return Icons.check_circle;
      case 'schedule':
        return Icons.schedule;
      case 'trending_up':
        return Icons.trending_up;
      case 'trending_down':
        return Icons.trending_down;
      default:
        return Icons.bar_chart;
    }
  }

  static Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      case 'purple':
        return Colors.purple;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({
    required this.label,
    required this.value,
    required this.color,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json['label'],
      value: json['value'].toDouble(),
      color: ReportMetric._getColorFromString(json['color']),
    );
  }
}

class ComplaintSummary {
  final String month;
  final int totalComplaints;
  final int resolved;
  final int pending;
  final int overdue;

  ComplaintSummary({
    required this.month,
    required this.totalComplaints,
    required this.resolved,
    required this.pending,
    required this.overdue,
  });

  factory ComplaintSummary.fromJson(Map<String, dynamic> json) {
    return ComplaintSummary(
      month: json['month'],
      totalComplaints: json['total_complaints'],
      resolved: json['resolved'],
      pending: json['pending'],
      overdue: json['overdue'],
    );
  }
}

class ZonePerformance {
  final String zoneName;
  final double efficiency;
  final int totalRoutes;
  final int completedRoutes;
  final int activeComplaints;

  ZonePerformance({
    required this.zoneName,
    required this.efficiency,
    required this.totalRoutes,
    required this.completedRoutes,
    required this.activeComplaints,
  });

  factory ZonePerformance.fromJson(Map<String, dynamic> json) {
    return ZonePerformance(
      zoneName: json['zone_name'],
      efficiency: json['efficiency'].toDouble(),
      totalRoutes: json['total_routes'],
      completedRoutes: json['completed_routes'],
      activeComplaints: json['active_complaints'],
    );
  }
}
