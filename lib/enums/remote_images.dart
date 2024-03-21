enum RemoteImages {
  //Misc
  NONE;

  String get url =>
      "https://firebasestorage.googleapis.com/v0/b/spotted-f3589.appspot.com/o/src%2F"
      "${_url ?? name.toLowerCase() + (name.contains("AVATAR") ? ".png" : ".jpg")}?alt=media";

  final String? _url;

  const RemoteImages([this._url]);
}
