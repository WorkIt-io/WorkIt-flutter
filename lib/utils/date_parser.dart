import 'package:intl/intl.dart';

DateTime parseCommunityDate(String dateToParse) {
  DateFormat format = DateFormat('EEEE, MMMM d, yyyy – h:mm a');
  DateTime parsedDate = format.parse(dateToParse);
  return parsedDate;
}

String formatCommunityDateTime(DateTime dateToParse) {
  DateFormat format = DateFormat('EEEE, MMMM d, yyyy – h:mm a');
  String stringDate = format.format(dateToParse);
  return stringDate;
}

String formatToCommunityRow(DateTime dateToParse) {
  DateFormat format = DateFormat('E, d/M – H:m');
  String stringDate = format.format(dateToParse);
  return stringDate;
}
