// lib/models/campaign.dart
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  final String id;
  final String title;
  final String description;
  final String beneficiary;
  final int goalAmount;
  final int currentAmount;
  final int startTime;
  final int endTime;
  final bool verified;
  final int trustScore;
  final String category;
  final String location;
  final String medicalCondition;
  final bool kycVerified;
  final bool medicalDocsVerified;
  final int lastProofSubmitted;
  final int proofDeadline;
  final bool fundsLocked;
  final String etherfuseAccount;
  final int pesoExchangeRate;
  final String? imageUrl;
  final List<String>? medicalDocs;
  final double? latitude;
  final double? longitude;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.beneficiary,
    required this.goalAmount,
    required this.currentAmount,
    required this.startTime,
    required this.endTime,
    required this.verified,
    required this.trustScore,
    required this.category,
    required this.location,
    required this.medicalCondition,
    required this.kycVerified,
    required this.medicalDocsVerified,
    required this.lastProofSubmitted,
    required this.proofDeadline,
    required this.fundsLocked,
    required this.etherfuseAccount,
    required this.pesoExchangeRate,
    this.imageUrl,
    this.medicalDocs,
    this.latitude,
    this.longitude,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignToJson(this);

  double get progressPercentage => currentAmount / goalAmount * 100;
  
  int get pesoGoalAmount => (goalAmount * pesoExchangeRate) ~/ 10000;
  int get pesoCurrentAmount => (currentAmount * pesoExchangeRate) ~/ 10000;
  
  int get daysRemaining {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (now >= endTime) return 0;
    return ((endTime - now) / 86400).ceil();
  }
  
  bool get isActive => DateTime.now().millisecondsSinceEpoch ~/ 1000 < endTime;
  bool get isExpired => DateTime.now().millisecondsSinceEpoch ~/ 1000 >= endTime;
  bool get needsProof => lastProofSubmitted > 0 && DateTime.now().millisecondsSinceEpoch ~/ 1000 > proofDeadline;
}