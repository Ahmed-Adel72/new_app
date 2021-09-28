import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/app_cubit/cubit.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'cubit.dart';
import '../../modules/search_screen.dart';


class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit=NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).changeNewsMode();
                },
                icon: Icon(Icons.brightness_4_outlined,),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              items:  cubit.bottomItems ,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {

              cubit.changeBottomNavBar(index);
            },

          ),
        );
      },
    );
  }
}
