import 'package:json_annotation/json_annotation.dart';
import 'package:elder_care/interfaces/json_serializable.dart';
import 'user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements JSONSerializable {
  final String? authorUID;
  int timestamp;
  String description;
  String? acceptedUserUID;
  String elderName;
  String elderSurname;

  @JsonKey(includeFromJson: true, includeToJson: false)
  String? uid;

  @JsonKey(includeFromJson: false, includeToJson: false)
  User? author;

  Post({
    this.authorUID,
    this.timestamp = 0,
    this.description = "",
    this.uid,
    this.author,
    this.acceptedUserUID,
    String? elderName,
    String? elderSurname,
    List<User?>? lastFollowers,
  })  : elderName = elderName ?? "",
        elderSurname = elderSurname ?? "";

  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp);

  List<String> validate() {
    return <String>[];
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$PostToJson(this);
}
