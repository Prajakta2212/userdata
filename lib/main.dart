import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart';
import 'features/users/presentation/bloc/user_bloc.dart';
import 'features/users/presentation/pages/user_list_screen.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => sl<UserBloc>(),
        child: UserListScreen(),
      ),
    );
  }
}