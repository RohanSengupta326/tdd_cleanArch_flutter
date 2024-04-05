// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Users extends Equatable {
  Users({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [id, createdAt, name, avatar];
}
