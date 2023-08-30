import 'package:intl/intl.dart';

String generateTimestamp() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyyMMddHHmmss'); // e.g., 20230831083059 for 31st Aug 2023, 8:30:59 AM
  return formatter.format(now);
}