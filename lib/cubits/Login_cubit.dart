import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/Login_model.dart';
import 'package:shopping_app/shared/local/const.dart';
import 'package:shopping_app/shared/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  LoginModel? registerModel;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: "register",
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      registerModel = LoginModel.fromJson(value.data);
      Constant.token=registerModel!.data!.token!;
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: "login",
      data: {
        "email":email,
        "password":password,
      },
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      print(loginModel!.data!.email);
      Constant.token=loginModel!.data!.token!;

      emit(LoginSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class LoginErrorState extends LoginStates {}

class RegisterLoadingState extends LoginStates {}
class RegisterSuccessState extends LoginStates {}
class RegisterErrorState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}
