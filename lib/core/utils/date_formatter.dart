import 'package:intl/intl.dart';

String formatStoryDate(DateTime createdAt) {
  return DateFormat('dd/MM/yyyy').format(createdAt);
}
