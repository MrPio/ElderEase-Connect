import 'dart:ffi';

import 'package:elder_care/enums/post_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:elder_care/interfaces/json_serializable.dart';
import 'user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements JSONSerializable {
  String? authorUID;
  int timestamp;
  int regDateTimestamp;
  double hours;
  String? address;
  String description;
  String? acceptedUserUID;
  String elderName;
  String elderSurname;
  PostType postType;
  int? review;

  @JsonKey(includeFromJson: true, includeToJson: false)
  String? uid;

  @JsonKey(includeFromJson: false, includeToJson: false)
  User? author;

  Post(
      {this.authorUID,
      this.timestamp = 0,
      this.description = "",
      this.address,
      this.uid,
      this.author,
      this.acceptedUserUID,
      this.hours = 1,
      int? regDateTimestamp,
      String? elderName,
      String? elderSurname,
      List<User?>? lastFollowers,
      PostType? postType,
      this.review})
      : elderName = elderName ?? "",
        regDateTimestamp =
            regDateTimestamp ?? DateTime.now().millisecondsSinceEpoch,
        elderSurname = elderSurname ?? "",
        postType = postType??PostType.HOME;

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp);

  List<String> validate() {
    return <String>[];
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  String getStatus() {
    if (isValid) {
      return acceptedUserUID == null ? 'Scaduto' : 'In corso';
    } else {
      return 'Terminato';
    }
  }

  bool get hasBeenAccepted => acceptedUserUID != null;
  bool get isValid => DateTime.now().isBefore(date);

  @override
  Map<String, dynamic> toJSON() => _$PostToJson(this);
}
