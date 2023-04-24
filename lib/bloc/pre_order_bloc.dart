import 'package:flutter/foundation.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';

class PreOrderBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App State
  bool isLoading = false;
  bool isApiLoad = false;
  List<ItemVO?>? itemDemos;

  PreOrderBloc() {
    _showLoading();
    model.getAllItems().then((value) {
      itemDemos = value.items;
      _notifySafely();
      _hideLoading();
    });
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
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
