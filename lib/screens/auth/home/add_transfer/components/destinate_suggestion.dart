import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/auth/home/transactions_page/bloc/add_transfer_bloc.dart';
import 'package:icon/screens/components/bloc/firestore/firestore_bloc.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/widgets/empty_view.dart';

class DestinateSuggestion extends StatelessWidget {
  const DestinateSuggestion({
    Key? key,
    required this.focusNode,
    required this.destinationController,
  }) : super(key: key);
  final FocusNode focusNode;
  final TextEditingController destinationController;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final data = context
        .read<FirestoreBloc<PublicInfo>>()
        .allDoc
        .where((element) =>
            element.id != context.read<UserRepository>().getUser()!.uid)
        .toList();
    return Positioned(
      top: 120,
      right: 0,
      left: 0,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
          ),
        ),
        child: data.isEmpty
            ? EmptyView()
            : ListView.builder(
                padding: EdgeInsets.only(top: 10.h),
                itemCount: data.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    focusNode.unfocus();
                    destinationController.text = data[index].walletAddress;
                    context.read<AddTransferBloc>().add(
                          DestinationOnChange(
                              destination: data[index].walletAddress),
                        );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 10.w,
                    ),
                    child: _buildItem(context, data[index]),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, PublicInfo item) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40.r)),
          child: Center(
            child: Text(
              item.lastName.substring(0, 1).toUpperCase(),
              style: textTheme.button!.copyWith(
                  fontSize: 20.sp, color: ExpandedColor.fromHex("#222937")),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          item.email,
          style: textTheme.bodyText1!.copyWith(
            color: ExpandedColor.fromHex("#0000A0"),
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
