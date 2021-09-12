import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon/global/constants/app_constants.dart';
import 'package:icon/global/constants/assets_path.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon/route/app_routes.dart';
import 'package:icon/screens/auth/home/cubit/home_cubit.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/screens/section_cubit.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/screens/components/bloc/firestore/firestore_bloc.dart';
import 'package:icon/widgets/empty_view.dart';
import 'package:icon/widgets/input_panel.dart';
import 'package:icon/widgets/simple_rive_widget.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final info = context
        .read<FirestoreBloc<PublicInfo>>()
        .allDoc
        .findById(context.read<UserRepository>().getUser()!.uid);

    final textTheme = Theme.of(context).textTheme;
    if (info == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Not exist user!',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: ExpandedColor.fromHex("#347AF0"),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 20.w,
            ),
            child: BlocBuilder<HomeCubit, ProcessState>(
              builder: (context, state) {
                final Balance? balance = context.watch<HomeCubit>().balance;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity),
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 320.w,
                      child: Row(
                        children: [
                          Text(
                            "Hello, ${info.lastName}",
                            style: textTheme.subtitle1!
                                .copyWith(color: Colors.white, fontSize: 24.sp),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              context.read<SectionCubit>().signOut();

                              // Routes.pop(navigator: Routes.mainNavigator);
                              Routes.pop();
                            },
                            icon: Icon(Icons.exit_to_app, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text("Current Wallet Value",
                        style: textTheme.button!.copyWith(
                            color: ExpandedColor.fromHex("#D6E4F4"),
                            fontSize: 15.w)),
                    Text(
                        balance != null ? balance.icxBalance.toString() : "N/A",
                        style:
                            textTheme.headline5!.copyWith(color: Colors.white)),
                    Spacer(),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BlocBuilder<HomeCubit, ProcessState>(
              builder: (context, state) {
                return InputPanel(
                  height: 520.h,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 20.h),
                        child: Text(
                          "Latest transactions",
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: ExpandedColor.fromHex("#04279F"),
                              fontSize: 17.sp),
                        ),
                      ),
                      ..._buildListItem(context),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildListItem(BuildContext context) {
    final userInfo = context.watch<HomeCubit>().userInfo;
    if (userInfo == null) {
      return [
        SizedBox(height: 100.h),
        SimpleRiveWidget(
          rivePath: AssetPathConstants.loadingCatRive,
          simpleAnimation: AssetPathConstants.loadingCatSimpleAnimation,
          width: 150.h,
          height: 150.h,
        )
      ];
    }
    final data = userInfo.transactions;
    if (data.isEmpty) {
      return [
        SizedBox(height: 100.h),
        SimpleRiveWidget(
          rivePath: AssetPathConstants.loadingCatRive,
          simpleAnimation: AssetPathConstants.loadingCatSimpleAnimation,
          width: 150.h,
          height: 150.h,
        )
      ];
    }

    return data
        .map((e) => InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: e.txHash));
                ExpandedFlushbar.successFlushbar(context,
                        message: "Copy to Clipboard: ${e.to}")
                    .show(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: ExpandedColor.fromHex('#EDF1F9'),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(20, 70, 150, 0.15),
                      blurRadius: 3.w,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15.w),
                    Image.asset(
                      AssetPathConstants.icxIcon,
                      width: 30.w,
                      height: 30.h,
                    ),
                    SizedBox(width: 15.w),
                    SizedBox(
                      width: 180.w,
                      child: Text(e.txHash,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(fontSize: 18.sp)),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 20.w,
                      child: Text(e.amount,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(fontSize: 18.sp)),
                    ),
                    SizedBox(width: 15.w),
                    Text("ICX", style: Theme.of(context).textTheme.button),
                    SizedBox(width: 15.w),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
