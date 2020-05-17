class ExpService {
  final ServiceType _serviceType;
  final String _description;
  final List<String> _images;
  final String _userFullName;
  final String _userEmail;
  final String _userPhoneNumber;
  final Payment _payingMethod;
  Status _status;

  ExpService(this._serviceType, this._description, this._images, this._userFullName,
      this._userEmail, this._payingMethod, this._userPhoneNumber, this._status);

  ServiceType get serviceType => _serviceType;

  String get serviceDescription => _description;

  List<String> get serviceImages => _images;

  String get userFullName => _userFullName;

  String get userEmail => _userEmail;

  String get userPhoneNumber => _userPhoneNumber;

  Payment get payingMethod => _payingMethod;

  Status get serviceStatus => _status;

  set updateServiceStatus(Status newStatus) {
    _status = newStatus;
  }
}

enum Status {
  none,
  sent,
  in_progress,
  finished,
}

enum Payment {
  none,
  cash,
  transaction,
}

enum ServiceType {
  none,
  electricity,
  instalation,
  misc,
  paint,
  plomery,
  budget,
}
