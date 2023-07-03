// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_apps/shared/dialog/Qconfirmation_dialog.dart';
import 'package:healing_apps/shared/fun/get_token/get_token.dart';

import '../../../../logic/login/login_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String token = "";
  @override
  void initState() {
    super.initState();
    token = QGetToken(login: context.read<LoginBloc>()).data();
    token.isEmpty
        ? debugPrint("data Kosong")
        : debugPrint("Data token: $token");
  }

  @override
  Widget build(BuildContext context) {
    var login = context.read<LoginBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueGrey[800],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              qshowConfirmationDialog(
                  context: context,
                  ontap: () {
                    login.add(Logout(token: token));
                    Navigator.pop(context);
                  },
                  title: 'Logout',
                  message: 'Anda yakin ingin keluar?');
            },
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 110.0,
              ),
              width: MediaQuery.of(context).size.width,
              color: Colors.blueGrey[800],
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: BlocBuilder<LoginBloc, LoginState>(
                  bloc: login,
                  builder: (context, state) {
                    if (state is LoginLoaded) {
                      var item = state.dataUser;
                      var user = item['user'];

                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(user['avatar']),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user['email'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                  ),
                                ),
                                Text(
                                  user['name'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 16.0,
                              backgroundColor: Colors.blueGrey[900],
                              child: const Icon(
                                Icons.edit,
                                size: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
