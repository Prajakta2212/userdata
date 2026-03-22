// // presentation/pages/user_detail_screen.dart
// import 'package:flutter/material.dart';
// import '../../domain/entities/user.dart';

// class UserDetailScreen extends StatelessWidget {
//   final User user;

//   UserDetailScreen(this.user);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("User Detail")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 50,
//             backgroundImage: NetworkImage(user.avatar),
//           ),
//           SizedBox(height: 20),
//           Text(user.name, style: TextStyle(fontSize: 20)),
//           Text(user.email),
//         ],
//       ),
//     );
//   }
// }

// presentation/pages/user_detail_screen.dart
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            // 👤 Avatar with shadow
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: Image.network(
                    user.avatar,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.person, size: 60),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            // 🧑 Name
            Text(
              user.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 6),

            // 📧 Email
            Text(
              user.email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 20),

            // 📦 Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Email Row


                       Row(
                        children: [
                          Icon(Icons.perm_identity, color: Colors.green),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              user.id.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
     Divider(height: 20),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              user.name,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),

                      Divider(height: 20),
 Row(
                        children: [
                          Icon(Icons.email, color: Colors.green),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              user.email,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      // Name Row
                     
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // 🔘 Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Back"),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}