import 'package:intl/intl.dart';

customDateFormat({required String date, required String format}) =>
    DateFormat(format).format(DateTime.parse(date));
