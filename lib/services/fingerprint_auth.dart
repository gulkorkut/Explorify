import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class LocalAuth {
  static final _localAuth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try{
      return await _localAuth.canCheckBiometrics;
    }  on PlatformException catch(e) {
      return false;
    }
  }
  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType> [];
    }
  }

  static Future<bool> localAuthenticate() async{
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      print('No biometrics available');
      return false;
    }
    try {
      return await _localAuth.authenticate(
          localizedReason: 'Authenticate to login',
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true
      );
    } on PlatformException catch(e) {
      print('An error occurred. Please make sure you have your fingerprints set up.');
      return false;
    }
  }
}