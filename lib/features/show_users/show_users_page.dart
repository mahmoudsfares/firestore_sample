import 'package:firestore_sample/entity/user.dart';
import 'package:firestore_sample/features/show_users/show_users_viewmodel.dart';
import 'package:flutter/material.dart';

class ShowUsersPage extends StatefulWidget {
  const ShowUsersPage({super.key});

  @override
  State<ShowUsersPage> createState() => _ShowUsersPageState();
}

class _ShowUsersPageState extends State<ShowUsersPage> {
  late ShowUsersViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ShowUsersViewModel();
    Future.delayed(Duration.zero, () => viewModel.getUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: StreamBuilder<List<User>>(
            stream: viewModel.usersStream,
            builder: (context, snapshot) {
              List<User>? users = snapshot.data;
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              else if (snapshot.hasError || users == null) {
                return const Text('Error');
              }
              return Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: ['name', 'phone']
                        .map(
                          (header) => TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Text(
                                  header,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ...users.map(
                    (user) => TableRow(
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              user.name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              user.phone,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
