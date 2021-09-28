import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/app_cubit/states.dart';

import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(initialState) : super(AppInitialState());
  int currentIndex=0;
  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];


  List<Widget> screens=[

  ];
  List<String> titles=[
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  static AppCubit get(context)=>BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBar());
  }

  Future<String> getName() async
  {
    return('Ahmed Adel');
  }
  void createDatabase()
  {
     openDatabase(
      'todo.db',
      version:1,
      onCreate: (database , version)
      {
        print('database is created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,data TEXT,time TEXT,status TEXT)').then((value) {
          print('table is created');
        }).catchError((error){
          print('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database){
        getDataFromDatabase(database);
        print('database is opened');
      },
    ).then((value)
     {
      database=value;
      emit(AppCreateDatabaseState());

     });

  }
  Future insertToDatabase(
      {
        required String title,
        required String data,
        required String time,
      }) async
  {
     await database.transaction((txn) => txn.rawInsert(
        'INSERT INTO tasks (title, data, time, status)VALUES("$title","$data","$time","new")')
        .then((value) {
      print('$value inserted successfully');
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error When Inserting New Record ${error.toString()}');
      return null;
    }));

  }

   void getDataFromDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDatabaseState());
     database.rawQuery('SELECT * FROM tasks').then((value)
    {

      value.forEach((element)
      {
        if(element['status']=='new')

          newTasks.add(element);
        else if (element['status']=='done')

          doneTasks.add(element);
        else archivedTasks.add(element);


        }

      );
      emit(AppGetDatabaseState());


    });
  }



   void updateDatabase({
     required String status,
     required int id,
   }
      )async
  {
      database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id= ?',
        ['$status', id],
      ).then((value)
      {
        getDataFromDatabase(database);
        emit(AppUpdateDatabaseState());
      });


  }

  void deleteDatabase({
    required int id,
  }
      )async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });


  }


  bool isBottomSheet=false;
  IconData fabIcon=Icons.edit;

  void changeBottomSheetState(
  {
    required bool isSheet,
    required IconData icon,

  }
  ){
     isBottomSheet=isSheet;
     fabIcon=icon;
     emit(AppChangeBottomSheetState());
   }
  bool isDark=false;
  ThemeMode newsMode=ThemeMode.dark;

  void changeNewsMode()
  {
    isDark=!isDark;
    emit(AppChangeBottomSheetState());

  }



}
