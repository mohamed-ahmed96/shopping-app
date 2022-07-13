import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubits/Shop_Cubit.dart';
import 'package:shopping_app/screens/search_screen.dart';
import 'package:shopping_app/shared/component/component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopCubit()..getHomeData()..getCategories()..getFavourites(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener:(context, state) {},
        builder: (context, state){
          var cubit=ShopCubit.get(context);
          if(cubit.homeModel==null)
          {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }else{
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                actions: [
                  IconButton(
                      onPressed: (){
                        MyComponents.navigateTo(context, SearchScreen());
                      },
                      icon:const Icon(Icons.search)),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (int index){
                  cubit.changeBottomIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon:Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon:Icon(Icons.category_outlined),
                    label: "Categories",
                  ),
                  BottomNavigationBarItem(
                    icon:Icon(Icons.favorite),
                    label: "Favorites",
                  ),
                  BottomNavigationBarItem(
                    icon:Icon(Icons.settings),
                    label: "Settings",
                  ),
                ],
              ),
              body: cubit.screen()[cubit.currentIndex],

            );
          }
        },
      ),
    );
  }


}
