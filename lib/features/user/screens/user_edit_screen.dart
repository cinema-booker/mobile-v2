import 'package:cinema_booker/features/user/data/user_details_response.dart';
import 'package:cinema_booker/features/user/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booker/theme/theme_color.dart';
import 'package:cinema_booker/theme/theme_font.dart';
import 'package:cinema_booker/widgets/text_input.dart';

class UserEditScreen extends StatefulWidget {
  final int userId;

  const UserEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final UserService _userService = UserService();
  UserDetailsResponse? _user;

  @override
  void initState() {
    super.initState();

    _fetchUser();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  void _fetchUser() async {
    UserDetailsResponse? user = await _userService.details(
      context: context,
      userId: widget.userId,
    );

    setState(() {
      _user = user;
    });
  }

  void _editUser() {
    if (_formKey.currentState!.validate()) {
      _userService.edit(
        context: context,
        userId: widget.userId,
        name: _nameController.text,
      );
    }
  }

  Widget _buildForm(BuildContext context, UserDetailsResponse user) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Edit User",
            style: TextStyle(
              fontSize: ThemeFontSize.s32,
              color: ThemeColor.white,
            ),
          ),
          TextInput(
            hint: "Name",
            controller: _nameController,
            keyboardType: TextInputType.text,
            defaultValue: user.name,
          ),
          ElevatedButton(
            onPressed: _editUser,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _user == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildForm(context, _user!),
      ),
    );
  }
}
