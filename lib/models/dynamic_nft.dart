// lib/models/dynamic_nft.dart
import 'package:json_annotation/json_annotation.dart';

part 'dynamic_nft.g.dart';

enum TreeGrowthStage {
  @JsonValue('Seed')
  seed,
  @JsonValue('Sprout')
  sprout,
  @JsonValue('Sapling')
  sapling,
  @JsonValue('YoungTree')
  youngTree,
  @JsonValue('MatureTree')
  matureTree,
  @JsonValue('MightyTree')
  mightyTree,
}

@JsonSerializable()
class DynamicNFT {
  final String id;
  final String owner;
  final String campaignId;
  final int treeLevel;
  final int totalDonated;
  final int donationCount;
  final int createdAt;
  final int lastUpdated;
  final String metadataUri;
  final TreeGrowthStage growthStage;
  final List<String> specialAchievements;

  DynamicNFT({
    required this.id,
    required this.owner,
    required this.campaignId,
    required this.treeLevel,
    required this.totalDonated,
    required this.donationCount,
    required this.createdAt,
    required this.lastUpdated,
    required this.metadataUri,
    required this.growthStage,
    required this.specialAchievements,
  });

  factory DynamicNFT.fromJson(Map<String, dynamic> json) => _$DynamicNFTFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicNFTToJson(this);

  String get growthStageText {
    switch (growthStage) {
      case TreeGrowthStage.seed:
        return 'Semilla';
      case TreeGrowthStage.sprout:
        return 'Brote';
      case TreeGrowthStage.sapling:
        return 'Plántula';
      case TreeGrowthStage.youngTree:
        return 'Árbol Joven';
      case TreeGrowthStage.matureTree:
        return 'Árbol Maduro';
      case TreeGrowthStage.mightyTree:
        return 'Árbol Poderoso';
    }
  }

  String get stageEmoji {
    switch (growthStage) {
      case TreeGrowthStage.seed:
        return '🌱';
      case TreeGrowthStage.sprout:
        return '🌿';
      case TreeGrowthStage.sapling:
        return '🌳';
      case TreeGrowthStage.youngTree:
        return '🌲';
      case TreeGrowthStage.matureTree:
        return '🌴';
      case TreeGrowthStage.mightyTree:
        return '🌺';
    }
  }

  double get totalDonatedPesos => totalDonated / 10000.0;
}
