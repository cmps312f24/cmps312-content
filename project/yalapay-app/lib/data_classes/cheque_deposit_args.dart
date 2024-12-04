import 'package:yalapay/data_classes/cheques_args.dart';
import 'package:yalapay/models/cheque_deposit.dart';

class ChequeDepositArgs {
  final ChequesArgs? chequeArgs;
  final ChequeDeposit? chequeDeposit;
  final bool isAdd;

  ChequeDepositArgs({this.chequeDeposit, this.chequeArgs, this.isAdd = false});
}