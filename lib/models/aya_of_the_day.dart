
class AyaOfTheDay {
  final String? arText;
  final String? enTran;
  final String? surEnName;
  final int? surNumber;
  final String? arName;
  final int? surNumberInSurah;

  AyaOfTheDay({this.surNumberInSurah, this.arName, this.arText, this.enTran, this.surEnName, this.surNumber});



  factory AyaOfTheDay.fromJSON (Map<String, dynamic> json) {
    return AyaOfTheDay(
        arText: json['data'][0]['text'],
        enTran: json['data'][2]['text'],
        arName : json ['data'][0]['surah']['name'],
        surEnName: json ['data'][2]['surah']['englishName'],
        surNumberInSurah: json['data'][0]['numberInSurah'],
        surNumber: json ['data'][0]['surah']['number']);

  }
}