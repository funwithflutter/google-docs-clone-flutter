import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeltaData extends Equatable {
  final String user;

  /// String json Representation of delta
  final String delta;
  final String deviceId;

  const DeltaData({
    required this.user,
    required this.delta,
    required this.deviceId,
  });

  DeltaData copyWith({
    String? user,
    String? delta,
    String? deviceId,
  }) {
    return DeltaData(
      user: user ?? this.user,
      delta: delta ?? this.delta,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'delta': delta,
      'deviceId': deviceId,
    };
  }

  factory DeltaData.fromMap(Map<String, dynamic> map) {
    return DeltaData(
      user: map['user'] ?? '',
      delta: map['delta'] ?? '',
      deviceId: map['deviceId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeltaData.fromJson(String source) =>
      DeltaData.fromMap(json.decode(source));

  @override
  String toString() =>
      'DeltaData(user: $user, delta: $delta, deviceId: $deviceId)';

  @override
  List<Object?> get props => [user, delta, deviceId];
}
