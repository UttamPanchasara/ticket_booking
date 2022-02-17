import 'package:booking_app/common/text_style_extension.dart';
import 'package:booking_app/data/bloc/event/add_family_event.dart';
import 'package:booking_app/data/bloc/provider/add_family_bloc.dart';
import 'package:booking_app/data/bloc/state/add_family_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/ui/common/common_button.dart';
import 'package:booking_app/ui/common/transparent_background.dart';
import 'package:booking_app/utils/app_utils.dart';
import 'package:booking_app/utils/logs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFamilyScreen extends StatefulWidget {
  const AddFamilyScreen({Key? key}) : super(key: key);

  @override
  _AddFamilyScreenState createState() => _AddFamilyScreenState();
}

class _AddFamilyScreenState extends State<AddFamilyScreen> {
  TextEditingController familyNameController = TextEditingController();
  TextEditingController familyMembersController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late AddFamilyBloc _addFamilyBloc;

  @override
  void initState() {
    super.initState();
    _addFamilyBloc = AddFamilyBloc();
  }

  @override
  void dispose() {
    disposeTextController();
    super.dispose();
  }

  void disposeTextController() {
    familyNameController.dispose();
    familyMembersController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Family',
          style: Theme.of(context)
              .textTheme
              .text22()
              .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: BlocListener(
        bloc: _addFamilyBloc,
        listener: (context, state) {
          if (state is CreateFamilyStateComplete) {
            familyNameController.clear();
            familyMembersController.clear();
            AppUtils.instance.showToast('Family Created successfully');
            Navigator.pop(context);
          } else if (state is CreateFamilyStateError) {
            LogsUtil.instance.printLog(state.data.message ?? '');
            AppUtils.instance.showToast('Error while creating family');
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  TransparentBackground(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      controller: familyNameController,
                      autofocus: true,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.text18().copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Family Name',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .text22()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      validator: (value) {
                        var name = value?.trim();
                        if (name == null || name.isEmpty) {
                          return 'Please enter family name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TransparentBackground(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: familyMembersController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: Theme.of(context).textTheme.text18().copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Total Member',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .text22()
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      validator: (value) {
                        var totalMembers = value?.trim();
                        if (totalMembers == null || totalMembers.isEmpty) {
                          return 'Please enter total members';
                        } else {
                          int num = int.parse(totalMembers);
                          if (num < 0) {
                            return 'Please enter valid total members';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const Spacer(),
                  CommonButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        String name = familyNameController.text.trim();
                        int totalMembers =
                            int.parse(familyMembersController.text.trim());

                        _addFamilyBloc.add(CreateFamilyEvent(
                          familyData: FamilyData(
                            familyName: name,
                            totalMembers: totalMembers,
                          ),
                        ));
                      }
                    },
                    buttonText: 'ADD',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
