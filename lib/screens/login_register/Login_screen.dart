import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubits/Login_cubit.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/login_register/register_screen.dart';
import 'package:shopping_app/shared/component/component.dart';
import 'package:shopping_app/shared/local/cash_helper.dart';
import 'package:shopping_app/shared/local/const.dart';


class LoginScreen extends StatelessWidget {
  // const ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            // if (state.loginModel.status!) {
            //   print(state.loginModel.message);
            //   print(state.loginModel.data!.token);
            //   CacheHelper.saveData(
            //       key: 'token', value: state.loginModel.data!.token)
            //       .then((value) {
            //     token=state.loginModel.data!.token!;
            //     navigateAndFinish(
            //       context,
            //       ShopLayoutScreen(),
            //     );
            //   });
            // } else {
            //   print(state.loginModel.message);
            //   // showToast(
            //   //     text: state.loginModel.message!, state: ToastStates.ERROR);
            // }

            //Constant.token=LoginCubit.get(context).loginModel!.data!.token!;
            CashHelper.saveData(
                key: "token",
                value: LoginCubit.get(context).loginModel!.data!.token!)
                .then((value) {
              if(value){
                MyComponents.navigateAndFinish(context, const HomeScreen());
              }
            });
          }else if(state is LoginErrorState) {
            Flushbar(
              title:  "attention!",
              message:  "that is an error occurred",
              duration:  const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ).show(context);


          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'login now to brows our new offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      MyComponents.defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      MyComponents.defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) return 'password is required ';
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: LoginCubit.get(context).isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate())
                            {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }

                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account',
                          ),
                          TextButton(
                            onPressed: () {
                              // Fluttertoast.showToast(
                              //     msg: "This is Center Short Toast",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                              MyComponents.navigateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            child: const Text("REGISTER"),
                          ),
                          // defaultTextButton(
                          //   function: () {
                          //     navigateTo(
                          //       context,
                          //       ShopRegisterScreen(),
                          //     );
                          //   },
                          //   text: 'register now',
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

