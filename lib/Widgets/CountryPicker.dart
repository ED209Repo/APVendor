class country {
  static country worldwide = country(
    phoneCode: '',
    countryCode: 'WW',
    e164Sc: -1,
    geographic: false,
    level: -1,
    name: 'World Wide',
    example: '',
    displayName: 'World Wide (WW)',
    displayNameNoCountryCode: 'World Wide', // Add the missing comma here
    e164Key: '', // Add the property value here
  );

  /// The country phone code
  final String phoneCode;

  /// The country code, ISO (alpha-2)
  final String countryCode;
  final int e164Sc;
  final bool geographic;
  final int level;
  // Add other properties if needed

  // Constructor for the Country class
  country({
    required this.phoneCode,
    required this.countryCode,
    required this.e164Sc,
    required this.geographic,
    required this.level,
    required String example,
    required String name,
    required String displayName,
    required String e164Key,
    required String displayNameNoCountryCode,
    // Add other properties if needed
  });
}