class CalendarModel {
  Res? res;
  CalendarModel({this.res});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? Res.fromJson(json['res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (res != null) {
      data['res'] = res!.toJson();
    }
    return data;
  }
}

class Res {
  int? id;
  String? eventDate;
  String? eventDateHindi;
  String? eventDayHindi;
  String? thought;
  String? veerSanwat;
  String? khartarSanwat;
  String? vikramSanwat;
  String? isaviSanwat;
  String? shubhDayTime;
  String? chanchalDayTime;
  String? laabhDayTime;
  String? amritDayTime;
  String? shubhNightTime;
  String? chanchalNightTime;
  String? laabhNightTime;
  String? amritNightTime;
  String? city1;
  String? sunrise1;
  String? sunset1;
  String? city2;
  String? sunrise2;
  String? sunset2;
  String? city3;
  String? sunrise3;
  String? sunset3;
  String? city4;
  String? sunrise4;
  String? sunset4;
  String? city5;
  String? sunrise5;
  String? sunset5;
  String? city6;
  String? sunrise6;
  String? sunset6;
  String? jainMonth;
  String? jainMonthNo;
  String? date;
  String? createdAt;
  String? updatedAt;

  Res(
      {this.id,
        this.eventDate,
        this.eventDateHindi,
        this.eventDayHindi,
        this.thought,
        this.veerSanwat,
        this.khartarSanwat,
        this.vikramSanwat,
        this.isaviSanwat,
        this.shubhDayTime,
        this.chanchalDayTime,
        this.laabhDayTime,
        this.amritDayTime,
        this.shubhNightTime,
        this.chanchalNightTime,
        this.laabhNightTime,
        this.amritNightTime,
        this.city1,
        this.sunrise1,
        this.sunset1,
        this.city2,
        this.sunrise2,
        this.sunset2,
        this.city3,
        this.sunrise3,
        this.sunset3,
        this.city4,
        this.sunrise4,
        this.sunset4,
        this.city5,
        this.sunrise5,
        this.sunset5,
        this.city6,
        this.sunrise6,
        this.sunset6,
        this.jainMonth,
        this.jainMonthNo,
        this.date,
        this.createdAt,
        this.updatedAt});

  Res.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventDate = json['eventDate'];
    eventDateHindi = json['eventDateHindi'];
    eventDayHindi = json['eventDayHindi'];
    thought = json['thought'];
    veerSanwat = json['veer_sanwat'];
    khartarSanwat = json['khartar_sanwat'];
    vikramSanwat = json['vikram_sanwat'];
    isaviSanwat = json['isavi_sanwat'];
    shubhDayTime = json['shubh_day_time'];
    chanchalDayTime = json['chanchal_day_time'];
    laabhDayTime = json['laabh_day_time'];
    amritDayTime = json['amrit_day_time'];
    shubhNightTime = json['shubh_night_time'];
    chanchalNightTime = json['chanchal_night_time'];
    laabhNightTime = json['laabh_night_time'];
    amritNightTime = json['amrit_night_time'];
    city1 = json['city_1'];
    sunrise1 = json['sunrise_1'];
    sunset1 = json['sunset_1'];
    city2 = json['city_2'];
    sunrise2 = json['sunrise_2'];
    sunset2 = json['sunset_2'];
    city3 = json['city_3'];
    sunrise3 = json['sunrise_3'];
    sunset3 = json['sunset_3'];
    city4 = json['city_4'];
    sunrise4 = json['sunrise_4'];
    sunset4 = json['sunset_4'];
    city5 = json['city_5'];
    sunrise5 = json['sunrise_5'];
    sunset5 = json['sunset_5'];
    city6 = json['city_6'];
    sunrise6 = json['sunrise_6'];
    sunset6 = json['sunset_6'];
    jainMonth = json['jain_month'];
    jainMonthNo = json['jain_month_no'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventDate'] = eventDate;
    data['eventDateHindi'] = eventDateHindi;
    data['eventDayHindi'] = eventDayHindi;
    data['thought'] = thought;
    data['veer_sanwat'] = veerSanwat;
    data['khartar_sanwat'] = khartarSanwat;
    data['vikram_sanwat'] = vikramSanwat;
    data['isavi_sanwat'] = isaviSanwat;
    data['shubh_day_time'] = shubhDayTime;
    data['chanchal_day_time'] = chanchalDayTime;
    data['laabh_day_time'] = laabhDayTime;
    data['amrit_day_time'] = amritDayTime;
    data['shubh_night_time'] = shubhNightTime;
    data['chanchal_night_time'] = chanchalNightTime;
    data['laabh_night_time'] = laabhNightTime;
    data['amrit_night_time'] = amritNightTime;
    data['city_1'] = city1;
    data['sunrise_1'] = sunrise1;
    data['sunset_1'] = sunset1;
    data['city_2'] = city2;
    data['sunrise_2'] = sunrise2;
    data['sunset_2'] = sunset2;
    data['city_3'] = city3;
    data['sunrise_3'] = sunrise3;
    data['sunset_3'] = sunset3;
    data['city_4'] = city4;
    data['sunrise_4'] = sunrise4;
    data['sunset_4'] = sunset4;
    data['city_5'] = city5;
    data['sunrise_5'] = sunrise5;
    data['sunset_5'] = sunset5;
    data['city_6'] = city6;
    data['sunrise_6'] = sunrise6;
    data['sunset_6'] = sunset6;
    data['jain_month'] = jainMonth;
    data['jain_month_no'] = jainMonthNo;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}