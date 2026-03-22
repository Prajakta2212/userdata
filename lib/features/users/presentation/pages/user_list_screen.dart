// // presentation/pages/user_list_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/user_bloc.dart';
// import 'user_detail_screen.dart';

// class UserListScreen extends StatefulWidget {
//   @override
//   State<UserListScreen> createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   final controller = ScrollController();

//   @override
//   void initState() {
//     context.read<UserBloc>().add(FetchUsers());

//     controller.addListener(() {
//       if (controller.position.pixels ==
//           controller.position.maxScrollExtent) {
//         context.read<UserBloc>().add(LoadMoreUsers());
//       }
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Users')),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: TextField(
//               onChanged: (v) =>
//                   context.read<UserBloc>().add(SearchUsers(v)),
//               decoration: InputDecoration(
//                 hintText: "Search...",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: BlocBuilder<UserBloc, UserState>(
//               builder: (_, state) {
//                 if (state is UserLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (state is UserError) {
//                   return Center(child: Text(state.message));
//                 }
//                 if (state is UserLoaded) {
//                   if (state.users.isEmpty) {
//                     return Center(child: Text("No users found"));
//                   }

//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       context.read<UserBloc>().add(FetchUsers());
//                     },
//                     child: ListView.builder(
//                       controller: controller,
//                       itemCount: state.users.length,
//                       itemBuilder: (_, i) {
//                         final user = state.users[i];

//                         return ListTile(
//                           leading: CircleAvatar(
//   radius: 35,
//   backgroundColor: Colors.grey.shade200,
//   child: ClipOval(
//     child: Image.network(
//       user.avatar,
//       width: 50,
//       height: 50,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return Icon(Icons.person, size: 30);
//       },
//       loadingBuilder: (context, child, progress) {
//         if (progress == null) return child;
//         return CircularProgressIndicator(strokeWidth: 2);
//       },
//     ),
//   ),
// ),
//                           title: Text(user.name),
//                           subtitle: Text(user.email),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) =>
//                                     UserDetailScreen(user),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   );
//                 }
//                 return SizedBox(height: 20);
//               },
//             ),
//           ),
       
       
       
       
       
       
       
//         ],
//       ),
//     );
//   }
// }



// presentation/pages/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final controller = ScrollController();
final FocusNode searchFocusNode = FocusNode();
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUsers());

    controller.addListener(() {
      if (controller.position.pixels ==
          controller.position.maxScrollExtent) {
        context.read<UserBloc>().add(LoadMoreUsers());
      }
    });

 WidgetsBinding.instance.addPostFrameCallback((_) {
    searchFocusNode.unfocus();
  });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); 
     searchFocusNode.dispose();// ✅ prevent memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return  GestureDetector(
  onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔍 Search Box
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
                focusNode: searchFocusNode, 
              onChanged: (v) =>
                  context.read<UserBloc>().add(SearchUsers(v)),
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 📋 List
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, state) {
                // 🔄 Loading
                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // ❌ Error
                if (state is UserError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserBloc>().add(FetchUsers());
                          },
                          child: Text("Retry"),
                        )
                      ],
                    ),
                  );
                }

                // ✅ Loaded
                if (state is UserLoaded) {
                  if (state.users.isEmpty) {
                    return Center(child: Text("No users found"));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<UserBloc>().add(FetchUsers());
                    },
                    child: ListView.builder(
                      controller: controller,
                      itemCount: state.users.length,
                      itemBuilder: (_, i) {
                        final user = state.users[i];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                               searchFocusNode.unfocus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      UserDetailScreen(user),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shadowColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    // 👤 Avatar
                          CircleAvatar(
  radius: 30,
  backgroundColor: Colors.grey.shade200,
  child: ClipOval(
    child: user.avatar.isNotEmpty
        ? Image.network(
  user.avatar,
  width: 60,
  height: 60,
  fit: BoxFit.cover,
  errorBuilder: (_, __, ___) {
    return Image.network(
      "https://picsum.photos/200?random=${user.id}",
      fit: BoxFit.cover,
    );
  },
)
        : Icon(Icons.person, size: 30),
  ),
),           // CircleAvatar(
                                    //   radius: 30,
                                    //   backgroundColor:
                                    //       Colors.grey.shade200,
                                    //   child: ClipOval(
                                    //     child: Image.network(
                                    //       user.avatar,
                                    //       width: 60,
                                    //       height: 60,
                                    //       fit: BoxFit.cover,
                                    //       errorBuilder: (_, __, ___) =>
                                    //           Icon(Icons.person,
                                    //               size: 30),
                                    //     ),
                                    //   ),
                                    // ),

                                    SizedBox(width: 12),

                                    // 📄 User Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            user.id.toString(),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ➡️ Arrow
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return SizedBox();
              },
            ),
          ),
        ],
      ),
    )
 ); }
}