import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/account.dart';
import '../../../data/models/beneficiary.dart';
import '../../../data/models/transfer.dart';

/// Available beneficiaries for the transfer flow.
final beneficiariesProvider = FutureProvider<List<Beneficiary>>(
  (ref) => ref.watch(beneficiariesRepositoryProvider).getBeneficiaries(),
);

/// Flat fee applied to a transfer (kept simple for the demo).
double transferFeeFor(double amount) => 0;

/// State for the multi-step Send-Money flow.
class TransferState {
  const TransferState({
    this.fromAccount,
    this.beneficiary,
    this.amount = 0,
    this.note,
    this.submission = const AsyncData<Transfer?>(null),
  });

  final Account? fromAccount;
  final Beneficiary? beneficiary;
  final double amount;
  final String? note;

  /// Idle = AsyncData(null); in-flight = AsyncLoading; done = AsyncData(transfer).
  final AsyncValue<Transfer?> submission;

  double get fee => transferFeeFor(amount);
  double get total => amount + fee;
  bool get canReview =>
      fromAccount != null && beneficiary != null && amount > 0;

  TransferState copyWith({
    Account? fromAccount,
    Beneficiary? beneficiary,
    double? amount,
    String? note,
    AsyncValue<Transfer?>? submission,
  }) {
    return TransferState(
      fromAccount: fromAccount ?? this.fromAccount,
      beneficiary: beneficiary ?? this.beneficiary,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      submission: submission ?? this.submission,
    );
  }
}

class TransferController extends Notifier<TransferState> {
  @override
  TransferState build() => const TransferState();

  void selectFromAccount(Account account) =>
      state = state.copyWith(fromAccount: account);

  void selectBeneficiary(Beneficiary beneficiary) =>
      state = state.copyWith(beneficiary: beneficiary);

  void setAmount(double amount) => state = state.copyWith(amount: amount);

  void setNote(String? note) => state = state.copyWith(note: note);

  void reset() => state = const TransferState();

  Future<void> submit() async {
    final s = state;
    if (!s.canReview) return;
    state = state.copyWith(submission: const AsyncLoading<Transfer?>());
    final result = await AsyncValue.guard<Transfer?>(() async {
      return ref
          .read(transferRepositoryProvider)
          .createTransfer(
            TransferRequest(
              fromAccountId: s.fromAccount!.id,
              toBeneficiaryId: s.beneficiary!.id,
              amount: s.amount,
              fee: s.fee,
              note: s.note,
            ),
          );
    });
    state = state.copyWith(submission: result);
  }
}

final transferControllerProvider =
    NotifierProvider<TransferController, TransferState>(TransferController.new);
