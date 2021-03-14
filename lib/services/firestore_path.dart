class FirestorePath {
  static String profile(String userUid) => 'users/$userUid';
  static String services(String userUid) => 'users/$userUid/services';
  static String service(String userUid, String serviceUid) => 'users/$userUid/services/$serviceUid';
}