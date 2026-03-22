// presentation/bloc/user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class LoadMoreUsers extends UserEvent {}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);
}

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;
  UserLoaded(this.users, this.hasReachedMax);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repo;

  int page = 1;
  List<User> allUsers = [];

  UserBloc(this.repo) : super(UserLoading()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        page = 1;
        final users = await repo.getUsers(page);
        allUsers = users;
        emit(UserLoaded(users, false));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<LoadMoreUsers>((event, emit) async {
      page++;
      final more = await repo.getUsers(page);
      if (more.isEmpty) {
        emit(UserLoaded(allUsers, true));
      } else {
        allUsers.addAll(more);
        emit(UserLoaded(allUsers, false));
      }
    });
on<SearchUsers>((event, emit) {
  final query = event.query.trim().toLowerCase();

  final filtered = allUsers
      .where((u) => u.name.toLowerCase().contains(query))
      .toList();

  // 🔥 Remove duplicates using ID
  final uniqueMap = {
    for (var user in filtered) user.id: user
  };

  final uniqueUsers = uniqueMap.values.toList();

  emit(UserLoaded(uniqueUsers, true));
});
    // on<SearchUsers>((event, emit) {
    //   final query = event.query.trim().toLowerCase();

    //   final filtered = allUsers
    //       .where((u) => u.name.toLowerCase().contains(query))
    //       .toList();

    //   emit(UserLoaded(filtered, true));
    // });
  }
}