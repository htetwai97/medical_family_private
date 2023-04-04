import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/persistence/share_preference/share_preference.dart';

class RegisterPageOneBloc extends ChangeNotifier {
  /// bloc State
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();


  /// App states
  String? name;
  String? contactNumber;
  String? shippingAddress;
  bool isUnlockNextButton = false;

  RegisterPageOneBloc();

  void unLockNextButton() {
    if (name != null &&
        contactNumber != null &&
        shippingAddress != null &&
        name != "" &&
        contactNumber != "" &&
        shippingAddress != "") {
      isUnlockNextButton = true;
      _notifySafely();
    } else {
      isUnlockNextButton = false;
      _notifySafely();
    }
  }

  void onNameChange(String? name) {
    this.name = name;
    _notifySafely();
    unLockNextButton();
  }

  void onContactNumberChange(String? contactNumber) {
    this.contactNumber = contactNumber;
    _notifySafely();
    unLockNextButton();
  }

  void onShippingAddressChange(String? shippingAddress) {
    this.shippingAddress = shippingAddress;
    _notifySafely();
    unLockNextButton();
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
