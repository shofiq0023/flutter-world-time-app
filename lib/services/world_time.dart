import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location shown of the ui
  String time = ""; // time shown to the user
  String flag; // url to asset flag icon
  String url; // location url for api endpoint
  bool isDayTime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri url = Uri.https('worldtimeapi.org', 'api/timezone/${this.url}');

      Response res = await get(url);

      Map data = jsonDecode(res.body);
      String dateTimeRes = data['utc_datetime'];
      String offsetHour = data['utc_offset'];
      String hour = offsetHour.substring(1, 3);

      DateTime now = DateTime.parse(dateTimeRes);
      now = now.add(Duration(hours: int.parse(hour)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Caught error: $e");
      time = "Could not get time";
    }
  }
}
