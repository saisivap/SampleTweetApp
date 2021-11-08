String calHoursDaysWeeksAndYears(DateTime pastDate) {
  DateTime presentDateTime = DateTime.now();
  final differenceInMin = presentDateTime.difference(pastDate).inMinutes;
  final differenceInHours = presentDateTime.difference(pastDate).inHours;
  if (differenceInMin < 59) {
    return differenceInMin.toString() + " min ago";
  }
  if (differenceInHours <= 24) {
    return differenceInHours.toString() + "h ago";
  } else if (differenceInHours <= 168) {
    final diffInDays = presentDateTime.difference(pastDate).inDays;
    if (diffInDays == 1) {
      return "1 day ago";
    } else {
      return diffInDays.toString() + " days ago";
    }
  } else {
    final diffInDays = presentDateTime.difference(pastDate).inDays;
    // if (diffInDays <= 30) {
    final numOfWeeks = (diffInDays / 7).floor();
    if (numOfWeeks <= 4) {
      if (numOfWeeks == 1) {
        return "1 week ago";
      } else {
        return numOfWeeks.toString() + " weeks ago";
      }
    } else if (diffInDays <= 365) {
      final numOfMonths = (numOfWeeks / 4).floor();
      if (numOfMonths == 1) {
        return "1 month ago";
      } else {
        return numOfMonths.toString() + " Months ago";
      }
    } else {
      final numOfYears = (numOfWeeks / 52).ceil();
      if (numOfYears == 1) {
        return "1 year ago";
      } else {
        return numOfYears.toString() + " years ago";
      }
    }
    // return (diffInDays / 7).floor().toString();
  }
  // }
  // return "";
}
