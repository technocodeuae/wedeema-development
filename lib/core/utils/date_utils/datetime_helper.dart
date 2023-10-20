import 'package:flutter/material.dart';
import '../../../../core/di/di_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/custom_timesago/timeago.dart' as timeago;


class DateTimeHelper {
  DateTimeHelper._() {
    timeago.setLocaleMessages(AppConsts.LANG_AR, timeago.ArMessages());
  }

  static const String DDMMYYYY_WITH_COMMA = 'dd, MM, yyyy';


  static getStanderDate(DateTime dateTime) {
    try {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute, dateTime.second);
    } catch (e) {
      return DateTime.now();
    }
  }

  /// This function will format the DateTime object to be in timestamp format
  static String formatDateWithTimestamp(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    if (dateTime.difference(dateTime).inDays < 31) {

      return timeago.format(dateTime,
          locale: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    } else {
      return formatDate(dateTime);
    }
  }

  static String formatDate(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    if (dateTime.year == DateTime.now().year) {
      var format = DateFormat.MMMd(
          DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
      var dateString = format.format(dateTime);
      return dateString;
    } else {
      var dateString = formatAsFullDate(dateTime);
      return dateString;
    }
  }

  static String formatDateMMM(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    try {
      var format =
          DateFormat.MMM(DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
      var dateString = format.format(dateTime);
      return dateString;
    } catch (e) {
      print('Error in DateTimeHelper $e');
    }
    return '';
  }

  static String formatDateYMMMd(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format =
        DateFormat.yMMM(DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatDateddMMMyy(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        'dd MMM - yy', DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatDateHourMinute(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        'HH:mm a', DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  /// ADDING NEW PATTERN FOR DATE EXAMPLE IS 5 Am / 2 PM
  static String formatDateHourAMOrPM(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        'h a', DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatDatedddMMyyyy(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat('dd - MM - yyyy',
        DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  /// SPECIAL FORMAT
  static String formatDatedddMMyyyySpecialFormat(DateTime? dateTime,
      {String? newPattern, String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        newPattern, DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatDateddMMMyyyy(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat('dd - MMM - yyyy',
        DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatDateMMMMEEEd(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat('dd - MM - yyyy - hh:mm a',
        DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatDateHHMMA(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        'hh:mm a', DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatHM(int lateness) {
    if (lateness < 60) return '$lateness';
    return '${(lateness / 60).toStringAsFixed(1)}';
  }

  static bool isMin(int lateness) {
    if (lateness < 60) return true;
    return false;
  }

  static bool isInSameWeek(DateTime first, DateTime second) {
    if (first.year == second.year &&
        first.month == second.month &&
        first.day == second.day) return true;
    if (first.isAfter(second) || first.difference(second).inDays.abs() <= 7)
      return true;
    return false;
  }

  static String formatAsFullDate(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        'd, MMM, y', DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static String formatAsMMMY(DateTime? dateTime,
      {String nullDatePlaceholder = '-'}) {
    if (dateTime == null) return nullDatePlaceholder;
    var format = DateFormat(
        'MMM y', DIManager.findDep<ApplicationCubit>().appLanguage.languageCode);
    var dateString = format.format(dateTime);
    return dateString;
  }

  static DateTime durationAgo(Duration duration) {
    return DateTime.now().subtract(duration);
  }

  static DateTime? parse(String? dateTimeString) {
    try {
      if (dateTimeString == null) return null;
      return DateTime.tryParse(dateTimeString);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String formatAnnualDuration(Duration? duration,
      {String nullDatePlaceholder = '-'}) {
    if (duration == null) return nullDatePlaceholder;
    final aYear = Duration(days: 365);
    final aMonth = Duration(days: 30);

    final StringBuffer buffer = StringBuffer();

    int allDays = duration.inDays;
    final int years = (allDays / aYear.inDays).floor();
    allDays -= years * aYear.inDays;
    final int months = (allDays / aMonth.inDays).floor();
    if (years > 0) {
      buffer.write('$years ${translate('yrs')}');
    }
    if (months > 0) {
      if (buffer.toString().isNotEmpty) {
        buffer.write(' & ');
      }
      buffer.write('$months ${translate('mos')}');
    }

    return buffer.toString();
  }

  static Future<DateTime?> picker(
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) {
    return showDatePicker(
        context: Get.context!,
        initialDate: initialDate ?? DateTime.now().subtract(Duration(days: 1)),
        firstDate:
            firstDate ?? DateTime.now().subtract(Duration(days: 365 * 40)),
        lastDate: lastDate ?? DateTime.now().subtract(Duration(days: 1)),
        builder: (context, widget) => Theme(
            data: ThemeData.light().copyWith(
              primaryColor:
                  DIManager.findDep<AppColorsController>()
                      .primaryColor,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: ColorScheme.light(
                  primary:
                      DIManager.findDep<AppColorsController>()
                          .primaryColor).copyWith(secondary: DIManager.findDep<AppColorsController>()
                      .primaryColor),
            ),
            child: widget!));
  }

  static String todayInName(
    DateTime? date, {
    String nullDatePlaceholder = '-',
  }) {
    final lang = DIManager.findDep<ApplicationCubit>().appLanguage.languageCode;
    if (date == null) return nullDatePlaceholder;
    return DateFormat.E(lang).format(date);
  }

  static String todayInNumber(
    DateTime? date, {
    String nullDatePlaceholder = '-',
  }) {
    if (date == null) return nullDatePlaceholder;
    return DateFormat.d().format(date);
  }
}
