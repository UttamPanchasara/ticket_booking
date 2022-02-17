import 'package:booking_app/common/text_style_extension.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/ui/common/common_button.dart';
import 'package:booking_app/ui/common/transparent_background.dart';
import 'package:booking_app/ui/seatselection/helper/model/seat_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailForm extends StatefulWidget {
  final SeatInfo seatInfo;
  final bool isLastMember;
  final bool isFirstMember;
  final Function onNext;
  final Function onBack;
  final Members? memberDetail;

  const DetailForm({
    Key? key,
    required this.seatInfo,
    required this.isLastMember,
    required this.isFirstMember,
    required this.onNext,
    required this.onBack,
    this.memberDetail,
  }) : super(key: key);

  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Members? member = widget.memberDetail;
    if (member != null) {
      nameController.text = member.name ?? '';
      phoneNumberController.text = member.phoneNumber ?? '';
    }
  }

  @override
  void dispose() {
    disposeTextController();
    super.dispose();
  }

  void disposeTextController() {
    nameController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return detailForm();
  }

  Widget detailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 24.h),
          Row(
            children: [
              Text(
                'Seat No.:',
                style: Theme.of(context).textTheme.text22().copyWith(
                    fontWeight: FontWeight.w700, color: Colors.black12),
              ),
              SizedBox(width: 16.w),
              Text(
                '${widget.seatInfo.seatNo}',
                style: Theme.of(context)
                    .textTheme
                    .text22()
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          TransparentBackground(
            child: TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              controller: nameController,
              autofocus: true,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .text18()
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your Name',
                hintStyle: Theme.of(context)
                    .textTheme
                    .text22()
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              validator: (value) {
                var name = value?.trim();
                if (name == null || name.isEmpty) {
                  return 'Please enter your name';
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
              controller: phoneNumberController,
              maxLength: 12,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: Theme.of(context)
                  .textTheme
                  .text18()
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone Number',
                hintStyle: Theme.of(context)
                    .textTheme
                    .text22()
                    .copyWith(fontWeight: FontWeight.w700),
                counterText: '',
              ),
              validator: (value) {
                const pattern = r'(^(?:[+0]9)?[0-9]{8,12}$)';
                final regExp = RegExp(pattern);

                var phoneNumber = value?.trim();
                if (phoneNumber == null || phoneNumber.isEmpty) {
                  return 'Please enter phone number';
                } else if ((!regExp.hasMatch(phoneNumber))) {
                  return 'Please enter valid phone number';
                }
                return null;
              },
            ),
          ),
          const Spacer(),
          Row(
            children: [
              if (!widget.isFirstMember) ...[
                Expanded(
                  child: CommonButton(
                    onTap: () {
                      widget.onBack();
                    },
                    buttonText: 'Back',
                  ),
                ),
                SizedBox(width: 8.w)
              ],
              Expanded(
                child: CommonButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String name = nameController.text.trim();
                      String phoneNumber = phoneNumberController.text.trim();

                      widget.onNext(
                        Members(
                            name: name,
                            phoneNumber: phoneNumber,
                            seatNo: widget.seatInfo.seatNo),
                      );
                    }
                  },
                  buttonText: widget.isLastMember ? 'Done' : 'Next',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
