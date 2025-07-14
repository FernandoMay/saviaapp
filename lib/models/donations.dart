// lib/models/donation.dart
import 'package:json_annotation/json_annotation.dart';

part 'donation.g.dart';

@JsonSerializable()
class Donation {
  final String id;
  final String campaignId;
  final String donor;
  final int amount;
  final int pesoAmount;
  final int timestamp;
  final bool nftMinted;
  final bool anonymous;
  final bool refunded;
  final String etherfuseTxId;
  final String? campaignTitle;
  final String? donorName;

  Donation({
    required this.id,
    required this.campaignId,
    required this.donor,
    required this.amount,
    required this.pesoAmount,
    required this.timestamp,
    required this.nftMinted,
    required this.anonymous,
    required this.refunded,
    required this.etherfuseTxId,
    this.campaignTitle,
    this.donorName,
  });

  factory Donation.fromJson(Map<String, dynamic> json) => _$DonationFromJson(json);
  Map<String, dynamic> toJson() => _$DonationToJson(this);

  DateTime get donationDate => DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  
  double get xlmAmount => amount / 10000000.0;
  double get pesoAmountFormatted => pesoAmount / 10000.0;
}