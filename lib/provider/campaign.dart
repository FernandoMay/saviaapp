// lib/providers/campaign_provider.dart
import 'package:flutter/foundation.dart';
import '../models/campaign.dart';
import '../services/api_service.dart';

class CampaignProvider extends ChangeNotifier {
  final _apiService = ApiService();

  List<Campaign> _campaigns = [];
  List<Campaign> _myCampaigns = [];
  Campaign? _selectedCampaign;
  bool _isLoading = false;
  String? _error;

  List<Campaign> get campaigns => _campaigns;
  List<Campaign> get myCampaigns => _myCampaigns;
  Campaign? get selectedCampaign => _selectedCampaign;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCampaigns() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _campaigns = await _apiService.getCampaigns();
    } catch (e) {
      _error = 'Error al cargar campañas: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMyCampaigns(String walletAddress) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _myCampaigns = await _apiService.getMyCampaigns(walletAddress);
    } catch (e) {
      _error = 'Error al cargar mis campañas: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createCampaign({
    required String title,
    required String description,
    required String medicalCondition,
    required int goalAmount,
    required int durationDays,
    required String category,
    required String location,
    required String etherfuseAccount,
    required String walletAddress,
    String? imageUrl,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final campaignId = await _apiService.createCampaign(
        title: title,
        description: description,
        medicalCondition: medicalCondition,
        goalAmount: goalAmount,
        durationDays: durationDays,
        category: category,
        location: location,
        etherfuseAccount: etherfuseAccount,
        walletAddress: walletAddress,
        imageUrl: imageUrl,
      );

      await loadCampaigns();
      await loadMyCampaigns(walletAddress);
      return true;
    } catch (e) {
      _error = 'Error al crear campaña: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectCampaign(String campaignId) async {
    _selectedCampaign = _campaigns.firstWhere(
      (campaign) => campaign.id == campaignId,
      orElse: () => _myCampaigns.firstWhere(
        (campaign) => campaign.id == campaignId,
      ),
    );
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  List<Campaign> searchCampaigns(String query) {
    if (query.isEmpty) return _campaigns;
    
    return _campaigns.where((campaign) {
      return campaign.title.toLowerCase().contains(query.toLowerCase()) ||
             campaign.description.toLowerCase().contains(query.toLowerCase()) ||
             campaign.category.toLowerCase().contains(query.toLowerCase()) ||
             campaign.location.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<Campaign> getCampaignsByCategory(String category) {
    return _campaigns.where((campaign) => campaign.category == category).toList();
  }

  List<Campaign> getFeaturedCampaigns() {
    return _campaigns.where((campaign) => 
      campaign.verified && campaign.trustScore > 70 && campaign.isActive
    ).take(5).toList();
  }

  List<Campaign> getUrgentCampaigns() {
    return _campaigns.where((campaign) => 
      campaign.isActive && campaign.daysRemaining <= 7
    ).toList();
  }
}