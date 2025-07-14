

// lib/utils/constants.dart
class Constants {
  static const String APP_NAME = 'Savia';
  static const String STELLAR_NETWORK = 'testnet';
  static const String CONTRACT_ID = 'CCJZ5DGASBWKOKQMHGHM3XFIVVR7QFGXM44CXCQZGQWQZXVQZXVQZXVQ';
  static const String HORIZON_URL = 'https://horizon-testnet.stellar.org';
  static const String ETHERFUSE_API_URL = 'https://api.etherfuse.com';
  
  // Mexican peso constants
  static const String PESO_SYMBOL = '\$';
  static const String PESO_CODE = 'MXN';
  static const int PESO_DECIMALS = 2;
  
  // XLM constants
  static const String XLM_SYMBOL = 'XLM';
  static const int XLM_DECIMALS = 7;
  static const int STROOPS_PER_XLM = 10000000;
  
  // Medical categories
  static const List<String> MEDICAL_CATEGORIES = [
    'Cirugía',
    'Tratamiento de Cáncer',
    'Medicamentos',
    'Terapia',
    'Emergencia Médica',
    'Rehabilitación',
    'Tratamiento Dental',
    'Salud Mental',
    'Otro'
  ];
  
  // Mexican states
  static const List<String> MEXICAN_STATES = [
    'Aguascalientes', 'Baja California', 'Baja California Sur',
    'Campeche', 'Chiapas', 'Chihuahua', 'Ciudad de México',
    'Coahuila', 'Colima', 'Durango', 'Guanajuato', 'Guerrero',
    'Hidalgo', 'Jalisco', 'México', 'Michoacán', 'Morelos',
    'Nayarit', 'Nuevo León', 'Oaxaca', 'Puebla', 'Querétaro',
    'Quintana Roo', 'San Luis Potosí', 'Sinaloa', 'Sonora',
    'Tabasco', 'Tamaulipas', 'Tlaxcala', 'Veracruz', 'Yucatán',
    'Zacatecas'
  ];
  
  // File upload limits
  static const int MAX_FILE_SIZE_MB = 10;
  static const List<String> ALLOWED_FILE_TYPES = [
    'pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'
  ];
  
  // Trust score thresholds
  static const int MIN_TRUST_SCORE = 0;
  static const int MAX_TRUST_SCORE = 100;
  static const int GOOD_TRUST_SCORE = 70;
  static const int EXCELLENT_TRUST_SCORE = 90;
  
  // Campaign limits
  static const int MIN_CAMPAIGN_DURATION_DAYS = 7;
  static const int MAX_CAMPAIGN_DURATION_DAYS = 365;
  static const int MIN_GOAL_AMOUNT_PESOS = 1000;
  static const int MAX_GOAL_AMOUNT_PESOS = 10000000;
}