import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/user_vo.dart';
import 'package:medical_family_app/network/responses/post_login_response.dart';
import 'package:medical_family_app/persistence/share_preference/share_preference.dart';

class RegisterPageTwoBloc extends ChangeNotifier {
  /// bloc State
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();


  /// App States
  String? userName;
  String? email;
  String? password;
  bool isUnlockRegisterButton = false;
  bool isLoading = false;

  RegisterPageTwoBloc();

  Future onTapRegisterButton(
      String? name, String? contactNumber, String? shippingAddress) {
    _showLoading();
    UserVO user = UserVO(
      name: name,
      phone: contactNumber,
      address: shippingAddress,
      userName: userName,
      email: email,
      password: password,
    );
    return model.postRegisterResponse(user).whenComplete(() => _hideLoading());
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void unlockRegisterButton() {
    if (userName != null &&
        email != null &&
        password != null &&
        userName != "" &&
        email != "" &&
        password != "") {
      isUnlockRegisterButton = true;
      _notifySafely();
    } else {
      isUnlockRegisterButton = false;
      _notifySafely();
    }
  }

  void onUserNameChange(String? userName) {
    this.userName = userName;
    _notifySafely();
    unlockRegisterButton();
  }

  void onEmailChange(String? email) {
    this.email = email;
    _notifySafely();
    unlockRegisterButton();
  }

  void onPasswordChange(String? password) {
    this.password = password;
    _notifySafely();
    unlockRegisterButton();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
