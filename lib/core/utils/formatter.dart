import 'package:intl/intl.dart';

customDateFormat({required dynamic date, required String format}) =>
    date == null ? null : DateFormat(format).format(DateTime.parse(date));
