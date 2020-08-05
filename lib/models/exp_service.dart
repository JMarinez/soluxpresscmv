import 'package:marinez_demo/constants/strings.dart';

class ExpService {
  final String uid;
  final int serviceType;
  final String description;
  final List<String> images;
  final String userUid;
  final String userFullName;
  final String userEmail;
  final String userPhoneNumber;
  final String address;
  final int payingMethod;
  final DateTime date;
  int status; //Change to private?

  ExpService({
    this.uid,
    this.serviceType,
    this.description,
    this.images,
    this.userUid,
    this.userFullName,
    this.userEmail,
    this.payingMethod,
    this.userPhoneNumber,
    this.status,
    this.address,
    this.date,
  });

  String getServiceTypeDescription(int serviceType) {
    if (serviceType == ServiceType.electricity.index) {
      return Strings.electricity;
    } else if (serviceType == ServiceType.instalation.index) {
      return Strings.instalation;
    } else if (serviceType == ServiceType.misc.index) {
      return Strings.misc;
    } else if (serviceType == ServiceType.paint.index) {
      return Strings.paint;
    } else if (serviceType == ServiceType.plomery.index) {
      return Strings.plomber;
    } else {
      return Strings.budget;
    }
  }

  String getStatusDescription(int status) {
    if (status == Status.sent.index) {
      return Strings.sent;
    } else if (status == Status.in_progress.index) {
      return Strings.inProgress;
    } else {
      return Strings.finished;
    }
  }

  updateStatus(int newStatus) {
    this.status = newStatus;
  }

  factory ExpService.fromMap(Map<String, dynamic> data, String docUid) {
    if (data == null) {
      return null;
    }

    final String uid = docUid;
    final String address = data['address'];
    final DateTime date = DateTime.parse(data['date'].toDate().toString());
    final String description = data['description'];
    final int payingMethod = data['payingMethod'];
    final int serviceType = data['serviceType'];
    final int statusIndex = data['status'];
    final String userUid = data['userUid'];
    final String userEmail = data['userEmail'];
    final String userFullName = data['userFullName'];
    final String userPhoneNumber = data['userPhoneNumber'];

    if (docUid == null) {
      return null;
    }
    if (serviceType == null) {
      return null;
    }
    if (statusIndex == null) {
      return null;
    }
    if (description == null) {
      return null;
    }
    if (userUid == null) {
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
      uid: uid,
      address: address,
      date: date,
      description: description,
      payingMethod: payingMethod,
      serviceType: serviceType,
      status: statusIndex,
      userUid: userUid,
      userEmail: userEmail,
      userFullName: userFullName,
      userPhoneNumber: userPhoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid' : uid,
      'address': address,
      'date': date,
      'description': description,
      'payingMethod': payingMethod,
      'serviceType': serviceType,
      'status': status,
      'userUid': userUid,
      'userEmail': userEmail,
      'userFullName': userFullName,
      'userPhoneNumber': userPhoneNumber,
    };
  }
}

int getServiceTypeIndex(String serviceType) {
    if (serviceType == Strings.electricity) {
      return ServiceType.electricity.index;
    } else if (serviceType == Strings.instalation) {
      return ServiceType.instalation.index;
    } else if (serviceType == Strings.misc) {
      return ServiceType.misc.index;
    } else if (serviceType == Strings.paint) {
      return ServiceType.paint.index;
    } else if (serviceType == Strings.plomber) {
      return ServiceType.plomery.index;
    } else {
      return ServiceType.budget.index;
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
