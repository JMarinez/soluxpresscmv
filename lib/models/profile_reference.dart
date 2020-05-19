class ProfileReference {
  final String userUid;
  final String email;
  final String displayName;
  final String phoneNumber;
  final String address;

  ProfileReference({
    this.userUid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.address,
  });

  factory ProfileReference.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    final String email = data['email'];
    final String displayName = data['displayName'];
    final String phoneNumber = data['phoneNumber'];
    final String address = data['address'];

    if (email == null) {
      return null;
    }
    if (displayName == null) {
      return null;
    }
    if (phoneNumber == null) {
      return null;
    }
    if (address == null) {
      return null;
    }

    return ProfileReference(
      email: email,
      displayName: displayName,
      phoneNumber: phoneNumber,
      address: address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
