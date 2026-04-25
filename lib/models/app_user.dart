import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final List<String> skills;
  final int points;
  final String role;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.skills,
    required this.points,
    required this.role,
    required this.createdAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    return AppUser(
      uid: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      skills: List<String>.from(data['skills'] ?? []),
      points: data['points'] ?? 0,
      role: data['role'] ?? 'user',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'skills': skills,
      'points': points,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
