import 'dart:math';

import 'package:fieldfreshmobile/feature/user/signup_flow/creation/bloc/states.dart';
import 'package:fieldfreshmobile/models/address_components.dart';
import 'package:fieldfreshmobile/models/api/error.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:fieldfreshmobile/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserSignupFlowCubit extends Cubit<UserSignUpFlowState> {
  final UserRepository _userRepository;
  final int maxSteps = 2;

  UserSignupFlowCubit(this._userRepository) : super(CredentialsStep(0));

  String email;
  String password;

  String firstName;
  String lastName;
  String phoneNumber;

  Proxy proxy = Proxy();

  int currentStep = 0;

  Future<void> saveCredentials(
      String email, String password, String confirmPassword) async {
    this.email = email;
    if (password != confirmPassword) {
      emit(Error("Passwords must match", _buildStep(currentStep)));
    } else if (!_isValidPassword(password)) {
      emit(Error(
          "Passwords must have at least 1 uppercase, 1 lower case, and be longer than 8 characters.",
          _buildStep(currentStep)));
    } else {
      this.password = password;
      currentStep = incrementStep();
      emit(_buildStep(currentStep));
    }
  }

  bool _isValidPassword(password) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(password);
  }

  Future<void> saveUserInfo(
      String firstName, String lastName, String phoneNumber) async {
    this.firstName = firstName;
    this.lastName = lastName;
    this.phoneNumber = phoneNumber;
    currentStep = incrementStep();
    emit(_buildStep(currentStep));
  }

  Future<void> saveProxy(AddressComponents components, LatLng latLng,
      String name, String desc) async {
    proxy.streetAddress = components.streetAddress;
    proxy.city = components.city;
    proxy.province = components.province;
    proxy.country = components.country;
    proxy.postalCode = components.postalCode;
    proxy.lat = latLng.latitude;
    proxy.long = latLng.longitude;
    proxy.name = name;
    proxy.description = desc;
    if (name == null) {
      proxy.name = "$firstName, $lastName";
    }
    currentStep = incrementStep();
    emit(_buildStep(currentStep));
    _doSignup();
  }

  int incrementStep() => min(currentStep + 1, maxSteps);

  Future<void> back() async {
    currentStep = max(0, currentStep - 1);
    emit(_buildStep(currentStep));
  }

  Future<void> _doSignup() async {
    try {
      User user = await _userRepository.signup(
          User(
              email: email,
              firstName: firstName,
              lastName: lastName,
              phone: phoneNumber),
          proxy,
          password);
      emit(SignupSuccess(user));
    } catch (e) {
      if (e is APIError) {
        emit(Error(e.message, _buildStep(currentStep)));
      } else {
        emit(Error("Unexpected error has occured", state));
      }
    }
  }

  SignupStepState _buildStep(int step) {
    if (step == 0) {
      return CredentialsStep(step, email: email);
    } else if (step == 1) {
      return UserInfoStep(step,
          firstName: firstName, lastName: lastName, phone: phoneNumber);
    } else if (step >= 2) {
      return ProxyStep(step, proxy);
    }
    return null;
  }
}
