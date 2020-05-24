import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marinez_demo/constants/strings.dart';

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
  final DateTime date;
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
    final DateTime date = DateTime.parse(data['date'].toDate().toString());
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

int getServiceTypeIndex(String serviceType) {
    if (serviceType == Strings.electricity) {
      return ServiceType.electricity.index;
    }
    else if (serviceType == Strings.instalation) {
      return ServiceType.instalation.index;
    }
    else if (serviceType == Strings.misc) {
      return ServiceType.misc.index;
    }
    else if (serviceType == Strings.paint) {
      return ServiceType.paint.index;
    }
    else if (serviceType == Strings.plomber) {
      return ServiceType.plomery.index;
    }
    else {
      return ServiceType.budget.index;
    }
  }
