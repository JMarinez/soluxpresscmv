class ExpService {
  final ServiceType _serviceType;
  final String _description;
  final List<String> _images;
  final String _userEmail;
  final String _userPhoneNumber;
  final Payment _payingMethod;
  Status _status;

  ExpService(this._serviceType, this._description, this._images,
      this._userEmail, this._payingMethod, this._userPhoneNumber);

  ServiceType get serviceType => _serviceType;

  String get serviceDescription => _description;

  List<String> get serviceImages => _images;

  String get userEmail => _userEmail;

  String get userPhoneNumber => _userPhoneNumber;

  Payment get payingMethod => _payingMethod;

  Status get serviceStatus => _status;

  set updateServiceStatus(Status newStatus) {
    _status = newStatus;
  }
}

enum Status {
  sent,
  in_progress,
  finished,
}

enum Payment {
  cash,
  transaction,
}

enum ServiceType {
  electricity,
  instalation,
  misc,
  paint,
  plomery,
  budget,
}
