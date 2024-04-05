// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Users extends Equatable {
  const Users({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  // empty model class .
  const Users.empty()
      : this(
          avatar: 'empty.avatar',
          createdAt: 'empty.createdAt',
          id: 'empty.id',
          name: 'empty.name',
        );

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [id, createdAt, name, avatar];
}
