// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';

// WE TEST ALL MODELS IN DATA LAYER.
class UserModel extends Users {
  const UserModel({
    required super.avatar,
    required super.createdAt,
    required super.id,
    required super.name,
  });

  const UserModel.empty()
      : this(
          avatar: "empty.avatar",
          createdAt: "empty.createdAt",
          id: "empty.id",
          name: "empty.name",
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar,
      'createdAt': createdAt,
      'id': id,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? avatar,
    String? createdAt,
    String? id,
    String? name,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
