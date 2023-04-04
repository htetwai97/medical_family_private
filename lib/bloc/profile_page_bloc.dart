import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';

class ProfilePageBloc extends ChangeNotifier {
  /// bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App States
  String userName = "";
  String email = "";
  String phone = "";
  String address = "";

  ProfilePageBloc() {
    model.getUserInfoString(USER_NAME).then((value) {
      userName = value;
      _notifySafely();
    });

    model.getUserInfoString(EMAIL).then((value) {
      email = value;
      _notifySafely();
    });

    model.getUserInfoString(CONTACT_NUMBER).then((value) {
      phone = value;
      _notifySafely();
    });

    model.getUserInfoString(SHIPPING_ADDRESS).then((value) {
      address = value;
      _notifySafely();
    });
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
