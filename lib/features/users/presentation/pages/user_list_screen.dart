
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
     searchFocusNode.dispose();
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
       
                if (state is UserLoading) {
                  return Center(child: CircularProgressIndicator());
                }

           
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
),  

                                    SizedBox(width: 12),

                                 
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