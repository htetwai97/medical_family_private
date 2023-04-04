import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/user_vo.dart';

class LoginPageBloc extends ChangeNotifier {
  /// bloc State
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App States
  String? userName;
  String? password;
  bool isLoading = false;
  bool isChecked = false;
  bool isUnlockLoginButton = false;

  LoginPageBloc();

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  Future onTapLoginButton() {
    _showLoading();
    UserVO user = UserVO(
      userName: userName,
      password: password,
    );
    return model.postLoginResponse(user).then((value) async {
      await model.saveUserInfoString(NAME, value.user?.name ?? "");
      await model.saveUserInfoString(CONTACT_NUMBER, value.user?.phone ?? "");
      await model.saveUserInfoString(
          SHIPPING_ADDRESS, value.user?.address ?? "");
      await model.saveUserInfoString(USER_NAME, value.user?.userName ?? "");
      await model.saveUserInfoString(EMAIL, value.user?.email ?? "");
      await model.saveUserInfoString(PASSWORD, value.user?.password ?? "");
      await model.saveUserInfoString(ACCESS_TOKEN, value.accessToken ?? "");
      await model.saveUserInfoString(USER_ID, value.user?.id?.toString() ?? "");
    }).whenComplete(() => _hideLoading());
  }

  void unlockLoginButton() {
    if (userName != null &&
        password != null &&
        userName != "" &&
        password != "" &&
        isChecked) {
      isUnlockLoginButton = true;
      _notifySafely();
    } else {
      isUnlockLoginButton = false;
      _notifySafely();
    }
  }

  void onUserNameChange(String? userName) {
    this.userName = userName;
    _notifySafely();
    unlockLoginButton();
  }

  void onPasswordChange(String? password) {
    this.password = password;
    _notifySafely();
    unlockLoginButton();
  }

  void onCheckTermAndCondition(bool isChecked) {
    this.isChecked = isChecked;
    _notifySafely();
    unlockLoginButton();
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
