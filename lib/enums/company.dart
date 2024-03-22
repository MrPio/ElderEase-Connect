enum Company {
  LIDL('Lidl'),
  SI('Si'),
  CONAD('Conad'),
  EUROSPIN('Eurospin'),
  SPOTIFY('Spotify'),
  AMAZON('Amazon');

  final String title;

  String get path =>
      "assets/images/companies/${title.toLowerCase()}.png";

  const Company(this.title);
}
