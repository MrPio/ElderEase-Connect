import 'package:elder_care/enums/gender.dart';
import 'package:elder_care/enums/user_type.dart';
import 'package:elder_care/interfaces/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'post.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements JSONSerializable {
  final String? name;
  final String? surname;
  final String? address;
  final String? cellNumber;
  final int regDateTimestamp;
  final int birthDateTimestamp;
  final UserType userType;
  final Gender gender;
  final List<String> postsUIDs;

  @JsonKey(includeFromJson: true, includeToJson: false)
  String? uid;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Post> posts;

  User({
    this.name = "Anonimo",
    this.surname = "",
    this.address,
    this.cellNumber,
    Gender? gender,
    UserType? userType,
    int? regDateTimestamp,
    int? birthDateTimestamp,
    List<String>? postsUIDs,
  })  : userType = userType ?? UserType.ELDER,
        gender = gender ?? Gender.OTHER,
        birthDateTimestamp = 0,
        regDateTimestamp =
            regDateTimestamp ?? DateTime.now().millisecondsSinceEpoch,
        postsUIDs = postsUIDs ?? [],
        posts = [];

  get dateReg => DateTime.fromMillisecondsSinceEpoch(regDateTimestamp);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$UserToJson(this);
}
