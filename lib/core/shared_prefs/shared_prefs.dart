import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/enums/employee_modes_enum.dart';
import '../../../../core/enums/login_modes_enum.dart';
import '../../../../core/notification/global_notification.dart';
import '../../../../data/models/auth/auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SharedPrefs {
  // Create storage
  final storage = new FlutterSecureStorage();


//  final isGuest = ReadWriteValue('isGuest${AppConst.appName}', false);
  final isFirstLaunch =
      ReadWriteValue('isFirstLaunch${AppConsts.appName}', true);
  final appLanguageCode =
      ReadWriteValue('appLanguageCode${AppConsts.appName}', AppConsts.LANG_AR);
  final firstLaunch = ReadWriteValue('firstLaunch${AppConsts.appName}', true);

  final appMode =
  ReadWriteValue('appMode${AppConsts.appName}', "light");

  ReadWriteValue<AuthenticateModel?> appAuth =
      ReadWriteValue('appAuth${AppConsts.appName}', null);
  ReadWriteValue<String?> appToken =
      ReadWriteValue('appToken${AppConsts.appName}', null);
  ReadWriteValue<bool?> isFirst =
  ReadWriteValue('isFirst${AppConsts.appName}', true);
  ReadWriteValue<String?> fcmToken =
  ReadWriteValue('fcmToken${AppConsts.appName}', null);
  ReadWriteValue<String?> deviceToken =
  ReadWriteValue('deviceToken${AppConsts.appName}', null);
  ReadWriteValue<String?> deviceType =
  ReadWriteValue('deviceType${AppConsts.appName}', null);
  ReadWriteValue<String?> appRefreshToken =
      ReadWriteValue('appRefreshToken${AppConsts.appName}', null);
  ReadWriteValue<String?> userID =
  ReadWriteValue('userID${AppConsts.appName}', null);
  ReadWriteValue<String?> userNamePerson =
  ReadWriteValue('user_name${AppConsts.appName}', null);
  ReadWriteValue<String?> notificationStatus =
  ReadWriteValue('notificationStatus${AppConsts.appName}', null);
  ReadWriteValue<String?> imageProfile =
  ReadWriteValue('imageProfile${AppConsts.appName}', null);
  ReadWriteValue<int> _loginMode =
      ReadWriteValue('loginMode${AppConsts.appName}', LoginModeEnum.NONE.index);
  ReadWriteValue<int> _employeeMode = ReadWriteValue(
      'employeeMode${AppConsts.appName}', EmployeeModesEnum.NONE.index);
  ReadWriteValue<String> _selectedWorkplace =
      ReadWriteValue('selectedWorkplace${AppConsts.appName}', '');


  ReadWriteValue<bool?> appEnableDisableTouchId =
  ReadWriteValue('appEnableDisableTouchId${AppConsts.appName}', null);

  ReadWriteValue<bool?> appEnableDisablePin =
  ReadWriteValue('appEnableDisablePin${AppConsts.appName}', null);


  LoginModeEnum getLoginMode() => LoginModeEnum.values[_loginMode.val];

  void setLoginMode(LoginModeEnum mode) {
    _loginMode.val = mode.index;
  }

  void logout() {
    setEmployeeMode(EmployeeModesEnum.NONE);
    setLoginMode(LoginModeEnum.NONE);
   // setAuth(null);
    setToken(null);
    setRefreshToken(null);
    setImageProfile(null);
    setNotificationsStatus(null);
    setIsFirst(true);

    //GlobalNotification.instance.deleteFCMToken();
  }

  EmployeeModesEnum getEmployeeMode() =>
      EmployeeModesEnum.values[_employeeMode.val];

  void setEmployeeMode(EmployeeModesEnum mode) {
    _employeeMode.val = mode.index;
  }




  Future<void> setAuthForBiometric(String org, String userName, String pass) async {

    // Write value
    await storage.write(key: 'appSelectedOrg${AppConsts.appName}', value: org);
    await storage.write(key: 'appUserName${AppConsts.appName}', value: userName);
    await storage.write(key: 'appPassword${AppConsts.appName}', value: pass);
  }

  Future<void> setAuthForPin(String pin) async {
    // Write value
    await storage.write(key: 'appSelectedPin${AppConsts.appName}', value: pin);
  }

  void setEnableDisablePin(bool enableDisablePin){
    appEnableDisablePin.val = enableDisablePin;
  }

  void setEnableDisableTouchId(bool enableDisableTouchId){
    appEnableDisableTouchId.val = enableDisableTouchId;
  }

  bool? hasEnableDisableTouchId(){
    return appEnableDisableTouchId.val;
  }

  bool? hasEnableDisablePin(){
    return appEnableDisablePin.val;
  }

  Future<String?> getOrg() async {
    // Read value
    String? value = await storage.read(key: 'appSelectedOrg${AppConsts.appName}');
    if(value != null){
      return value;
    }else{
      return null;
    }
  }

  Future<String?> getUserName() async {
    // Read value
    String? value = await storage.read(key: 'appUserName${AppConsts.appName}');
    if(value != null){
      return value;
    }else{
      return null;
    }
  }

  Future<String?> getPass() async {
    // Read value
    String? value = await storage.read(key: 'appPassword${AppConsts.appName}');
    if(value != null){
      return value;
    }else{
      return null;
    }
  }

  Future<String?> getPinCode() async {
    // Read value
    String? value = await storage.read(key: 'appSelectedPin${AppConsts.appName}');
    if(value != null){
      return value;
    }else{
      return null;
    }
  }


  Future<bool> hasBiometricAuth() async{
    if(await getOrg() != null && await getUserName() != null && await getPass() != null){
      return true;
    }else{
      return false;
    }
  }

  // void setAuth(AuthenticateModel? authenticateModel) {
  //   appAuth.val = authenticateModel;
  //   appToken.val = authenticateModel?.accessToken;
  //   appRefreshToken.val = authenticateModel?.refreshToken;
  // }

  setToken(String? token) {
    appToken.val = token;
  }

  setIsFirst(bool isFirst) {
    this.isFirst.val = isFirst;
  }


  setUserID(int? userId) {
    userID.val = userId.toString();
  }

  setUserNamePerson(String? userName) {
    userNamePerson.val = userName.toString();
  }
  setImageProfile(String? image) {
    imageProfile.val = image.toString();
  }

  setNotificationsStatus(String? statues) {
    notificationStatus.val = statues.toString();
  }




  setFCMToken(String? token) {
    fcmToken.val = token;
  }

  setDeviceToken(String? token) {
    deviceToken.val = token;
  }

  setDeviceType(String? type) {
    deviceType.val = type;
  }

  setRefreshToken(String? token) {
    appRefreshToken.val = token;
  }

  AuthenticateModel? getAuth() {
    if (!(appAuth.val?.isBlank ?? true)) {
      return appAuth.val;
    } else {
      return null;
    }
  }

  String? getToken() {
    return appToken.val;
  }

  bool? getIsFirst() {
    return isFirst.val;
  }


  String? getImageProfile() {
    return imageProfile.val;
  }

  String? getNotificationStatus() {
    return notificationStatus.val;
  }

  String? getUserID() {
    return userID.val;
  }

  String? getUserNamePerson() {
    return userNamePerson.val;
  }
  String? getFCMToken() {
    return fcmToken.val;
  }

  String? getDeviceToken() {
    return deviceToken.val;
  }

  String? getDeviceType() {
    return deviceType.val;
  }

  String? getRefreshToken() {
    return appRefreshToken.val;
  }

  /// ---------------------------------- Post views (user views) ----------------------------------
  ReadWriteValue<String> _viewedPosts =
      ReadWriteValue('viewedPosts${AppConsts.appName}', '');

  List<String> get viewedPostIds => _viewedPosts.val.split(':');

  void setPostViewed(int postId) {
    print('setPostViewed .....');
    _viewedPosts.val = '${_viewedPosts.val}${postId.toString()}:';
  }

  bool isPostViewed(int postId) {
    print('viewedPostIds $viewedPostIds');
    print('viewedPostIds ${viewedPostIds.length}');
    return viewedPostIds.contains(postId.toString());
  }
// ------------------------------------------------------------------------------------------------

}
