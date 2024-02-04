class Ulke {
  String flag;
  String name;
  String countryCode;
  String capital;
  String region;
  String language;
  int population;

  Ulke.fromMap(Map<String, dynamic> countryMap)
      : flag = countryMap["flags"]?["png"] ?? "",
        name = countryMap["name"]?["common"] ?? "",
        countryCode = countryMap["cca2"] ?? "",
        capital = (countryMap["capital"] as List<dynamic>).isNotEmpty ? countryMap["capital"][0] : "",
        region = countryMap["region"],
        population = countryMap["population"],
        language = (countryMap["languages"] as Map<String, dynamic>).isNotEmpty
            ? (countryMap["languages"] as Map<String, dynamic>).entries.toList()[0].value : "";

}




/*
[
   {
      "flags":{
         "png":"https://flagcdn.com/w320/tr.png",
         "svg":"https://flagcdn.com/tr.svg",
         "alt":"The flag of Turkey has a red field bearing a large fly-side facing white crescent and a smaller five-pointed white star placed just outside the crescent opening. The white crescent and star are offset slightly towards the hoist side of center."
      },
      "name":{
         "common":"Turkey",
         "official":"Republic of Turkey",
         "nativeName":{
            "tur":{
               "official":"Türkiye Cumhuriyeti",
               "common":"Türkiye"
            }
         }
      },
      "cca2":"TR",
      "capital":[
         "Ankara"
      ],
      "region":"Asia",
      "languages":{
         "tur":"Turkish"
      },
      "population":84339067
   }
]
 */