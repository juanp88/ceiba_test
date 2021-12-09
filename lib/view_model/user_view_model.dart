import 'package:flutter/cupertino.dart';
import 'package:users_test/models/user_model.dart';
import 'package:users_test/services/api_service.dart';
import 'package:users_test/services/api_status.dart';
import 'package:users_test/services/db_service.dart';

class UserViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<User> _userListModel = [];

  bool get isLoading => _isLoading;
  List<User> get userListModel => _userListModel;

  UserViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _isLoading = loading;
    notifyListeners();
  }

  setUserListModel(List<User> userListModel) {
    _userListModel = userListModel;
  }

  getUsers() async {
    setLoading(true);
    var dbList = await DBService.db.getAllUsers();
    setUserListModel(dbList);
    setLoading(false);
  }

  insertUser() async {
    var response = await UserApiProvider().getAllUsers();
    if (response is Success) {
      setUserListModel(response.response as List<User>);
    }
    setLoading(false);
  }

  connectApi() async {
    setLoading(true);
    var apiProvider = UserApiProvider();
    await apiProvider.getAllUsers();
    setLoading(false);
  }
}
