// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/kyc_record.dart';
import '../services/stellar_service.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final _stellarService = StellarService();
  final _apiService = ApiService();

  bool _isAuthenticated = false;
  String? _walletAddress;
  String? _privateKey;
  KYCRecord? _kycRecord;
  bool _isLoading = false;
  String? _error;

  bool get isAuthenticated => _isAuthenticated;
  String? get walletAddress => _walletAddress;
  KYCRecord? get kycRecord => _kycRecord;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isKYCVerified => _kycRecord?.isVerified ?? false;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      final address = await _storage.read(key: 'wallet_address');
      final privateKey = await _storage.read(key: 'private_key');

      if (address != null && privateKey != null) {
        _walletAddress = address;
        _privateKey = privateKey;
        _isAuthenticated = true;
        
        // Load KYC record
        await _loadKYCRecord();
      }
    } catch (e) {
      _error = 'Error al inicializar: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createWallet() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final keyPair = await _stellarService.createWallet();
      _walletAddress = keyPair['address'];
      _privateKey = keyPair['privateKey'];

      await _storage.write(key: 'wallet_address', value: _walletAddress);
      await _storage.write(key: 'private_key', value: _privateKey);

      _isAuthenticated = true;
      return true;
    } catch (e) {
      _error = 'Error al crear wallet: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> importWallet(String privateKey) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final address = await _stellarService.importWallet(privateKey);
      _walletAddress = address;
      _privateKey = privateKey;

      await _storage.write(key: 'wallet_address', value: _walletAddress);
      await _storage.write(key: 'private_key', value: _privateKey);

      _isAuthenticated = true;
      await _loadKYCRecord();
      return true;
    } catch (e) {
      _error = 'Error al importar wallet: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadKYCRecord() async {
    if (_walletAddress == null) return;

    try {
      _kycRecord = await _apiService.getKYCRecord(_walletAddress!);
    } catch (e) {
      print('Error loading KYC record: $e');
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
    _isAuthenticated = false;
    _walletAddress = null;
    _privateKey = null;
    _kycRecord = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}