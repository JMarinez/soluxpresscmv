class ExpService {
  final String uid;
  final int serviceType;
  final String description;
  final List<String> images;
  final String userFullName;
  final String userEmail;
  final String userPhoneNumber;
  final String address;
  final int payingMethod;
  final String date;
  final int status;

  ExpService({
    this.uid,
    this.serviceType,
    this.description,
    this.images,
    this.userFullName,
    this.userEmail,
    this.payingMethod,
    this.userPhoneNumber,
    this.status,
    this.address,
    this.date,
  });

  factory ExpService.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    final String address = data['address'];
    final String date = data['date'].toString();
    final String description = data['description'];
    final int payingMethod = data['payingMethod'];
    final int serviceType = data['serviceType'];
    final int statusIndex = data['status'];
    final String userEmail = data['userEmail'];
    final String userFullName = data['userFullName'];
    final String userPhoneNumber = data['userPhoneNumber'];

    if (serviceType == null) {
      return null;
    }
    if (statusIndex == null) {
      return null;
    }
    if (description == null) {
      return null;
    }
    if (userEmail == null) {
      return null;
    }
    if (userFullName == null) {
      return null;
    }
    if (userPhoneNumber == null) {
      return null;
    }
    if (address == null) {
      return null;
    }
    if (payingMethod == null) {
      return null;
    }
    if (date == null) {
      return null;
    }

    return ExpService(
      address: address,
      date: date,
      description: description,
      payingMethod: payingMethod,
      serviceType: serviceType,
      status: statusIndex,
      userEmail: userEmail,
      userFullName: userFullName,
      userPhoneNumber: userPhoneNumber,
    );
  }

  Status convertToStatus(int index) {
    if (index == Status.sent.index) {
      return Status.sent;
    }
    else if (index == Status.in_progress.index) {
      return Status.in_progress;
    }
    else {
      return Status.finished;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'date': date,
      'description': description,
      'payingMethod': payingMethod,
      'serviceType': serviceType,
      'status' : status,
      'userEmail': userEmail,
      'userFullName': userFullName,
      'userPhoneNumber': userPhoneNumber,
    };
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
