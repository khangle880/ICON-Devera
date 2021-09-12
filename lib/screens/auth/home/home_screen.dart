import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/global/constants/app_constants.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/auth/home/add_transfer/sliding_sheet_transfer.dart';
import 'package:icon/screens/components/bloc/firestore/firestore_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/widgets/bottom_app_bar_navigation.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';
import 'transactions_page/bloc/add_transfer_bloc.dart';
import 'transactions_page/transactions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTapped(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  Future showSheet(BuildContext context) {
    return showSlidingBottomSheet(
      context,
      useRootNavigator: true,
      builder: (_) => SlidingSheetDialog(
        cornerRadius: 30.r,
        color: Colors.white,
        snapSpec: SnapSpec(snappings: [0.5, 1]),
        builder: (_, state) => BlocProvider.value(
          value: context.read<FirestoreBloc<PublicInfo>>(),
          child: BlocProvider(
            create: (_) => AddTransferBloc(
                homeCubit: context.read<HomeCubit>(),
                userRepository: context.read<UserRepository>()),
            child: SlidingSheetTransfer(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(context.read<UserRepository>())..loadUserInfo(),
      child: BlocBuilder<HomeCubit, ProcessState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: GestureDetector(
              onTap: () async {
                await showSheet(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 15.h),
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  gradient: ColorConstants.kPrimaryGradientColor,
                ),
                child: Icon(
                  Icons.add,
                  size: 30.w,
                  color: ExpandedColor.fromHex("#FFFFFF"),
                ),
              ),
            ),
            bottomNavigationBar: FABBottomAppBar(
              items: [
                FABBottomAppBarItem(
                    iconData: Icons.check_circle_rounded, text: 'Transactions'),
                FABBottomAppBarItem(
                    iconData: Icons.grid_view_rounded, text: 'Portfolio'),
              ],
              // notchedShape: CircularNotchedRectangle(),
              centerItemText: '',
              height: 70.h,
              iconSize: 22.h,
              backgroundColor: ColorConstants.kBackgroundColor,
              onTabSelected: _onTapped,
              selectedColor: ExpandedColor.fromHex("#347AF0"),
              selectedBarColor: ExpandedColor.fromHex("#F27D1D"),
              defaultColor: ExpandedColor.fromHex("#78839C"),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 12.sp),
            ),
            body: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: const [
                // TransactionsPage(),
                // PortfolioPage(),
                TransactionsPage(),
                Scaffold(),
              ],
            ),
          );
        },
      ),
    );
  }
}
