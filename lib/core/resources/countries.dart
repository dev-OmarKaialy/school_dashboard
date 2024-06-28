const List<Country> countries = [
  Country(
    name: 'Syria',
    flag: "🇸🇾",
    code: "SY",
    dialCode: "+963",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'Egypt',
    flag: "🇪🇬",
    code: "EGY",
    dialCode: "+20",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'turkey',
    flag: "🇹🇷",
    code: "TR",
    dialCode: "90+",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'Iraq',
    flag: "🇮🇶",
    code: "IQ",
    dialCode: "964+",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: 'jordan',
    flag: "🇯🇴",
    code: "JO",
    dialCode: "962+",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: 'palestine',
    flag: "🇵🇸",
    code: "PS",
    dialCode: "970+",
    minLength: 9,
    maxLength: 9,
  ),
];

const defaultCountry = Country(
  name: 'iraq',
  flag: "🇮🇶",
  code: "IQ",
  dialCode: "964+",
  minLength: 10,
  maxLength: 10,
);

class Country {
  final String name;
  final String flag;
  final String code;
  final String dialCode;
  final String regionCode;
  final int minLength;
  final int maxLength;
  final String logo;

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.minLength,
    required this.maxLength,
    this.regionCode = "",
    this.logo = "iraqLogo",
  });

  String get fullCountryCode {
    return dialCode + regionCode;
  }

  String get displayCC {
    if (regionCode != "") {
      return "$dialCode $regionCode";
    }
    return dialCode;
  }

  @override
  String toString() {
    return 'Country{name: $name, flag: $flag, code: $code, dialCode: $dialCode, regionCode: $regionCode, minLength: $minLength, maxLength: $maxLength}';
  }
}
