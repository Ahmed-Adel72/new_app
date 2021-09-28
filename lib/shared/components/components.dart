import 'package:flutter/material.dart';
import 'package:news_app/layout/app_cubit/cubit.dart';
import 'package:news_app/modules/web_view_screen.dart';


Widget defaultButton({
  required double width,
  required Color background,
  required String text,
  required Function function,
}) =>  Container(
  color: background,
  width: width,
  child: MaterialButton(
    onPressed: (){function;},
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget myDivider()=> Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey,
);

void navigateTo(context, widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> widget,
  ),
);
Widget buildTaskItem(Map model, context) =>Dismissible(
  key:Key (model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children:

      [

        CircleAvatar(

          radius: 40.0,

          child: Text(

            '${model['time']}',

          ),

        ),



        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min ,

            children:

            [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['data']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),





            ],

          ),

        ),

        IconButton(

            onPressed: ()

            {

              AppCubit.get(context).updateDatabase(status: 'done', id: model['id'],);

            },

            icon: Icon(

              Icons.check_box,



            ),

          color: Colors.green,



        ),

        SizedBox(

          width: 15.0,

        ),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateDatabase(status: 'archived', id: model['id'],);

          },

          icon: Icon(

            Icons.archive,



          ),

          color: Colors.black45,



        ),



      ],

    ),

  ),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteDatabase(id:model['id']);

  },
);
Widget buildArticleItem(article, context,{isSearch = false}) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(

          width: 20.0,

        ),

        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

        ),



      ],

    ),

  ),
);
