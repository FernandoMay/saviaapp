
// lib/models/kyc_record.dart
import 'package:json_annotation/json_annotation.dart';

part 'kyc_record.g.dart';

enum KYCLevel {
  @JsonValue('Unverified')
  unverified,
  @JsonValue('BasicVerified')
  basicVerified,
  @JsonValue('MedicalVerified')
  medicalVerified,
  @JsonValue('FullyVerified')
  fullyVerified,
}

@JsonSerializable()
class KYCRecord {
  final String entity;
  final String curp;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;
  final KYCLevel verificationLevel;
  final int verifiedAt;
  final int expiresAt;
  final String? medicalLicense;
  final String? institution;

  KYCRecord({
    required this.entity,
    required this.curp,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.verificationLevel,
    required this.verifiedAt,
    required this.expiresAt,
    this.medicalLicense,
    this.institution,
  });

  factory KYCRecord.fromJson(Map<String, dynamic> json) => _$KYCRecordFromJson(json);
  Map<String, dynamic> toJson() => _$KYCRecordToJson(this);

  bool get isExpired => DateTime.now().millisecondsSinceEpoch ~/ 1000 >= expiresAt;
  bool get isVerified => verificationLevel != KYCLevel.unverified && !isExpired;
  
  String get verificationLevelText {
    switch (verificationLevel) {
      case KYCLevel.unverified:
        return 'No verificado';
      case KYCLevel.basicVerified:
        return 'Básico verificado';
      case KYCLevel.medicalVerified:
        return 'Médico verificado';
      case KYCLevel.fullyVerified:
        return 'Completamente verificado';
    }
  }
}
