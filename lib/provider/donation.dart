// lib/providers/donation_provider.dart
import 'package:flutter/foundation.dart';
import '../models/donation.dart';
import '../models/dynamic_nft.dart';
import '../services/api_service.dart';

class DonationProvider extends ChangeNotifier {
  final _apiService = ApiService();

  List<Donation> _donations = [];
  List<DynamicNFT> _nfts = [];
  bool _isLoading = false;
  String? _error;

  List<Donation> get donations => _donations;
  List<DynamicNFT> get nfts => _nfts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDonations(String walletAddress) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _donations = await _apiService.getDonations(walletAddress);
    } catch (e) {
      _error = 'Error al cargar donaciones: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadNFTs(String walletAddress) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _nfts = await _apiService.getNFTs(walletAddress);
    } catch (e) {
      _error = 'Error al cargar NFTs: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createDonation({
    required String campaignId,
    required String donorWalletAddress,
    required int amount,
    required int pesoAmount,
    required String etherfuseTxId,
    bool anonymous = false,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.createDonation(
        campaignId: campaignId,
        donorWalletAddress: donorWalletAddress,
        amount: amount,
        pesoAmount: pesoAmount,
        etherfuseTxId: etherfuseTxId,
        anonymous: anonymous,
      );
      await loadDonations(donorWalletAddress); // Reload donations for the donor
      return true;
    } catch (e) {
      _error = 'Error al crear donación: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}