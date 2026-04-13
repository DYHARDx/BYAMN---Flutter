import 'package:byamn/core/logs/app_logs.dart';

import '../../constants/secure_storage_constants/secure_storage_constants.dart';
import 'secure_storage_helper.dart';

class PreferenceRepository {
  static Future<void> setToken(String? token) async {
    if (token != null) {
      await SecureStorageHelper.write(SecureAppConstants.TOKEN_KEY, token);
    }
  }

  static Future<String?> getToken() async {
    return await SecureStorageHelper.read(SecureAppConstants.TOKEN_KEY);
  }

  static Future<void> setUserID(String? userID) async {
    PRINT_LOGS('user id', '$userID');
    if (userID != null) {
      await SecureStorageHelper.write(SecureAppConstants.USER_ID, userID);
    }
  }

  static Future<String?> getUserID() async {
    return await SecureStorageHelper.read(SecureAppConstants.USER_ID);
  }

  static Future<void> setAccountID(String? id) async {
    if (id != null) {
      await SecureStorageHelper.write(SecureAppConstants.ACCOUNT_ID, id);
    }
  }

  static Future<String?> getAccountID() async {
    return await SecureStorageHelper.read(SecureAppConstants.ACCOUNT_ID);
  }

  static Future<void> setUserPinCode(String? id) async {
    if (id != null) {
      await SecureStorageHelper.write(SecureAppConstants.USER_PIN_CODE, id);
    }
  }

  static Future<String?> getUserPinCode() async {
    return await SecureStorageHelper.read(SecureAppConstants.USER_PIN_CODE);
  }

  static Future<void> setIsLogin(bool value) async {
    await SecureStorageHelper.write(
      SecureAppConstants.IS_LOGIN_KEY,
      value.toString(),
    );
  }

  static Future<bool> getIsLogin() async {
    final value = await SecureStorageHelper.read(
      SecureAppConstants.IS_LOGIN_KEY,
    );
    return value == 'true';
  }

  // static Future<void> setConnectionStatus(String data) async {
  //   await SecureStorageHelper.write(
  //     SecureAppConstants.PLATFORM_CONNECTION_STATUS,
  //     data,
  //   );
  // }
  //
  // static Future<String?> getConnectionStatus() async {
  //   final value = await SecureStorageHelper.read(
  //     SecureAppConstants.PLATFORM_CONNECTION_STATUS,
  //   );
  //   return value;
  // }
  //
  // // static Future<void> setInstagramConnected(bool connected) async {
  // //   await SecureStorageHelper.write(
  // //     SecureAppConstants.IS_INSTAGRAM_CONNECTED,
  // //     connected.toString(),
  // //   );
  // // }
  // //
  // // static Future<bool> isInstagramConnected() async {
  // //   final value = await SecureStorageHelper.read(
  // //     SecureAppConstants.IS_INSTAGRAM_CONNECTED,
  // //   );
  // //   return value == 'true';
  // // }
  //
  // static Future<void> setUserModel(String data) async {
  //   print(data);
  //   await SecureStorageHelper.write(SecureAppConstants.USER_DATA, data);
  // }
  //
  // // static Future<UserModel?> getUserModel() async {
  // //   final value = await SecureStorageHelper.read(SecureAppConstants.USER_DATA);
  // //   if (value == null) return null;
  // //   return UserModel.fromJson(jsonDecode(value));
  // // }
  // //
  // // static Future<void> setInstagramToken(String? token) async {
  // //   if (token != null) {
  // //     await SecureStorageHelper.write(
  // //       SecureAppConstants.INSTAGRAM_TOKEN,
  // //       token,
  // //     );
  // //   }
  // // }
  //
  // static Future<String?> getInstagramToken() async {
  //   return await SecureStorageHelper.read(SecureAppConstants.INSTAGRAM_TOKEN);
  // }
  //
  // static Future<void> setNotificationPreferences(bool value) async {
  //   await SecureStorageHelper.write(
  //     SecureAppConstants.NOTIFICATION_PREFERENCES,
  //     value.toString(),
  //   );
  // }
  //
  // static Future<bool> getNotificationPreferences() async {
  //   final value = await SecureStorageHelper.read(
  //     SecureAppConstants.NOTIFICATION_PREFERENCES,
  //   );
  //   return value == 'true';
  // }
  //
  // static Future<void> setInstagramUserId(String? token) async {
  //   if (token != null) {
  //     await SecureStorageHelper.write(
  //       SecureAppConstants.INSTAGRAM_USERID,
  //       token,
  //     );
  //   }
  // }
  //
  // static Future<String?> getInstagramUserId() async {
  //   return await SecureStorageHelper.read(SecureAppConstants.INSTAGRAM_USERID);
  // }
  //
  // static Future<void> setInstagramPassword(String? token) async {
  //   final encryptor = SimpleEncryptor();
  //   if (token != null) {
  //     await SecureStorageHelper.write(
  //       SecureAppConstants.INSTAGRAM_PASSWORD,
  //       encryptor.encrypt(token),
  //     );
  //   }
  // }
  //
  // static Future<String?> getInstagramPassword() async {
  //   String? password = await SecureStorageHelper.read(
  //     SecureAppConstants.INSTAGRAM_PASSWORD,
  //   );
  //   if (password != null) {
  //     final encryptor = SimpleEncryptor();
  //     return encryptor.decrypt(password);
  //   }
  //   return null;
  // }

  static Future<void> clearAll() async {
    await SecureStorageHelper.clearAll(); // Clears everything in secure storage
  }
}
