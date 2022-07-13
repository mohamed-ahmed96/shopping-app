import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubits/search_cubit.dart';
import 'package:shopping_app/models/search_model.dart';
import 'package:shopping_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MyComponents.defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: "search",
                      prefix: Icons.search,
                      onChange: (String value) {
                        SearchCubit.get(context).productSearch(text: value);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SearchCubit.get(context).searchResult == null
                        ? const Text(
                      "search Result",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    )
                        : buildGrid(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget gridItem(Data1 product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product.image!),
                width: double.infinity,
                height: 200.0,
                //fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(product.name!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          Row(
            children: [
              Expanded(
                child: Text(
                  product.price!.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                ),
              ),
              //const SizedBox(width: 20),
              //Spacer(),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    // ShopCubit.get(context).changeFavourite(product.id!);
                    // ShopCubit.get(context).updateFavourites(product.id!);
                    // ShopCubit.get(context).getFavourites();
                  },
                  icon: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGrid(BuildContext context,state) {
    if (state is GetSearchResultsSuccessState) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 2.3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (context, index) => gridItem(
            SearchCubit.get(context).searchResult!.data!.data![index], context),
        itemCount: SearchCubit.get(context).searchResult!.data!.data!.length,
      );
    } else if (state is GetSearchResultsErrorState) {
      return const Text(
        "No Result Founded",
        style: TextStyle(
          fontSize: 30,
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );

    }
  }
}
