
// lib/models/trust_score.dart
import 'package:json_annotation/json_annotation.dart';

part 'trust_score.g.dart';

@JsonSerializable()
class TrustScore {
  final String entity;
  final int score;
  final int verificationLevel;
  final int donationCount;
  final int totalDonated;
  final int campaignsCreated;
  final int medicalDocsSubmitted;
  final int docsVerifiedOnTime;
  final int lateSubmissions;
  final int fraudReports;
  final int lastUpdated;

  TrustScore({
    required this.entity,
    required this.score,
    required this.verificationLevel,
    required this.donationCount,
    required this.totalDonated,
    required this.campaignsCreated,
    required this.medicalDocsSubmitted,
    required this.docsVerifiedOnTime,
    required this.lateSubmissions,
    required this.fraudReports,
    required this.lastUpdated,
  });

  factory TrustScore.fromJson(Map<String, dynamic> json) => _$TrustScoreFromJson(json);
  Map<String, dynamic> toJson() => _$TrustScoreToJson(this);

  String get scoreText {
    if (score >= 90) return 'Excelente';
    if (score >= 70) return 'Bueno';
    if (score >= 50) return 'Regular';
    if (score >= 30) return 'Bajo';
    return 'Muy Bajo';
  }

  Color get scoreColor {
    if (score >= 90) return const Color(0xFF4CAF50);
    if (score >= 70) return const Color(0xFF8BC34A);
    if (score >= 50) return const Color(0xFFFF9800);
    if (score >= 30) return const Color(0xFFFF5722);
    return const Color(0xFFF44336);
  }

  double get totalDonatedPesos => totalDonated / 10000.0;
}