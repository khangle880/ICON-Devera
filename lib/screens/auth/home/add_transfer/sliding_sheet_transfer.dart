import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/screens/auth/home/cubit/home_cubit.dart';
import 'package:icon/screens/auth/home/transactions_page/bloc/add_transfer_bloc.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/widgets/input_panel.dart';
import 'package:icon/widgets/normal_text_field.dart';
import 'package:icon/widgets/rounded_button.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'components/destinate_suggestion.dart';

class SlidingSheetTransfer extends StatefulWidget {
  const SlidingSheetTransfer({Key? key}) : super(key: key);

  @override
  _SlidingSheetTransferState createState() => _SlidingSheetTransferState();
}

class _SlidingSheetTransferState extends State<SlidingSheetTransfer> {
  late FocusNode focusNode;
  final TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    destinationController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InputPanel(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
      height: 500.h,
      child: BlocConsumer<AddTransferBloc, AddTransferState>(
        listener: (context, state) {
          final addStatus = state.addStatus;
          if (addStatus is Processing) {
            ExpandedFlushbar.loadingFlushbar(context, message: "Transfering...")
                .show(context);
          }
          if (addStatus is ProcessFailure) {
            ExpandedFlushbar.failureFlushbar(context,
                    message: addStatus.errorMessage)
                .show(context);
          }
          if (addStatus is ProcessSuccess) {
            Navigator.pop(context);
            ExpandedFlushbar.successFlushbar(context,
                    message: 'Transfer Successfully!')
                .show(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 50,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Icon(Icons.deck)),
                  Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      focusNode: focusNode,
                      style: Theme.of(context).textTheme.bodyText1,
                      controller: destinationController,
                      decoration: InputDecoration(
                        labelText: "Destination",
                        hintText: state.destination,
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value) {
                        SheetController.of(context)!.expand();
                        context
                            .read<AddTransferBloc>()
                            .add(DestinationOnChange(destination: value));
                      },
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      initialValue: state.amount,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        SheetController.of(context)!.expand();
                        context
                            .read<AddTransferBloc>()
                            .add(AmountOnChange(amount: value));
                      },
                    ),
                  ),
                  SizedBox(height: 50.h),
                  RoundedButton(
                    text: 'Transfer',
                    padding: EdgeInsets.symmetric(horizontal: 64.w),
                    onPressed: () {
                      context.read<AddTransferBloc>().add(AddTransferSubmit());
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
              if (focusNode.hasFocus)
                DestinateSuggestion(
                    focusNode: focusNode,
                    destinationController: destinationController)
            ],
          );
        },
      ),
    );
  }
}
