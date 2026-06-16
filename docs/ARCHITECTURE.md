# Architecture & Screen-Building Contract

Feature-first clean architecture. **Data → Repositories → Riverpod providers/controllers → Presentation.**
The core, data, shared, and application layers are ALREADY BUILT. When building a
presentation screen, consume the providers below — never call Dio or hardcode business data.

## Conventions (must follow)

- Flutter **Material 3 only** (`useMaterial3` is on). Use M3 components: `NavigationBar`,
  `NavigationRail`, `FilledButton`, `FilledButton.tonal`, `Card`, `SearchBar`, `SegmentedButton`,
  `Badge`, `showModalBottomSheet`, `AlertDialog`, `Chip`/`FilterChip`, M3 typography
  (`Theme.of(context).textTheme.*`), tonal surfaces (`scheme.surfaceContainer*`).
- **No inline colors / spacing.** Use `Theme.of(context).colorScheme` and the design tokens
  (`Spacing.*`, `Radii.*`, `Motion.*`) from `core/theme/design_tokens.dart`.
- Riverpod 3: screens are `ConsumerWidget` / `ConsumerStatefulWidget`. Read state with
  `ref.watch(...)`, call methods with `ref.read(provider.notifier).method()`.
- **`AsyncValue` nullable accessor is `.value`** (NOT `valueOrNull`). `.requireValue`,
  `.isLoading`, `.hasValue`, `.when(...)` also exist.
- Render async state with `AsyncValueView<T>` (shared widget) OR `.when(...)`. Always handle
  loading (skeleton), empty, and error (with retry) states.
- Format money/dates ONLY via `Formatters` (see below). Never show raw numbers/dates.
- Navigate with `go_router`: `import 'package:go_router/go_router.dart';` then
  `context.go(AppRoutes.x)` (tab switches) or `context.push(AppRoutes.x)` (detail/flows).
- Each screen returns its own `Scaffold` with an `AppBar`. Wrap wide bodies in `MaxWidthBody`
  for large screens. Be responsive (use `LayoutBuilder` / `MediaQuery` where it helps; multi-pane
  on width > 840 where noted).
- `const` constructors wherever possible. No unused imports/vars (analyzer must stay clean).
- Do NOT edit pubspec, run build_runner, or touch files outside your assigned list.

## Models — `lib/data/models/` (freezed; have `copyWith`, `==`)

```
User            { String id, name, email; String? phone, avatarColor }
Account         { String id, name, type, currency, accountNumberMasked; double balance }
                  // type is 'checking' | 'savings' | 'credit'
BankCard        { String id, accountId, brand, last4, holder, expiry, color; bool frozen }
AppTransaction  { String id, accountId, title, merchant, category, currency; double amount;
                  TransactionType type; TransactionStatus status; DateTime date }
  enum TransactionType { debit, credit }
  enum TransactionStatus { completed, pending, failed }
Beneficiary     { String id, name, bank, accountNumberMasked, avatarColor }
Transfer        { String id, status, fromAccountId, toBeneficiaryId; double amount, fee; DateTime date }
Insights        { String period; double total; List<CategorySpend> byCategory;
                  List<TrendPoint> trend; List<Budget> budgets }
  CategorySpend { String category; double amount; String color }
  TrendPoint    { String month; double amount }
  Budget        { String category; double spent, limit }
AppNotification { String id, title, body, type; bool read; DateTime date }
                  // type is 'transaction' | 'security' | 'promo' | 'system'
```
Color fields are hex strings — convert with `colorFromHex(hexString)` from
`core/utils/color_utils.dart`.

## Providers / controllers (import path → symbol)

Auth — `features/auth/application/auth_controller.dart`
- `authControllerProvider` → `AsyncNotifierProvider<AuthController, AuthSession>`
  - `AuthSession { User? user; bool authenticated }`
  - methods: `.login(email, password)`, `.register(name, email, password)`, `.logout()`

Onboarding — `features/onboarding/application/onboarding_controller.dart`
- `onboardingSeenProvider` → `NotifierProvider<_, bool>`; method `.complete()`

Accounts — `features/accounts/application/accounts_providers.dart`
- `accountsProvider` → `FutureProvider<List<Account>>`
- `totalBalanceProvider` → `Provider<AsyncValue<double>>`
- `primaryCurrencyProvider` → `Provider<String>`

Cards — `features/cards/application/cards_controller.dart`
- `cardsControllerProvider` → `AsyncNotifierProvider<CardsController, List<BankCard>>`
  - methods: `.refresh()`, `.toggleFreeze(id)`, `.addCard(BankCard)`
- `cardDetailProvider` → `FutureProvider.family<BankCard, String>`

Transactions — `features/transactions/application/transactions_controller.dart`
- `transactionsControllerProvider` → `AsyncNotifierProvider<_, TransactionsState>`
  - `TransactionsState { List<AppTransaction> items; TransactionQuery query; bool isLoadingMore, hasMore }`
  - methods: `.setSearch(String)`, `.setCategory(String?)`, `.setAccount(String?)`,
    `.setDateRange(DateTime?, DateTime?)`, `.loadMore()`, `.refresh()`, `.applyQuery(TransactionQuery)`
- `recentTransactionsProvider` → `FutureProvider<List<AppTransaction>>` (6 items, for dashboard)
- `transactionDetailProvider` → `FutureProvider.family<AppTransaction, String>`
- `kTransactionCategories` → `List<String>` (category keys for filter chips)

Transfer — `features/transfer/application/transfer_controller.dart`
- `beneficiariesProvider` → `FutureProvider<List<Beneficiary>>`
- `transferControllerProvider` → `NotifierProvider<TransferController, TransferState>`
  - `TransferState { Account? fromAccount; Beneficiary? beneficiary; double amount; String? note;
     AsyncValue<Transfer?> submission; double fee; double total; bool canReview }`
  - methods: `.selectFromAccount(Account)`, `.selectBeneficiary(Beneficiary)`, `.setAmount(double)`,
    `.setNote(String?)`, `.submit()`, `.reset()`
  - submission: idle = `AsyncData(null)`, in-flight = `AsyncLoading`, success = `AsyncData(transfer)`,
    error = `AsyncError`.

Insights — `features/insights/application/insights_providers.dart`
- `insightsProvider` → `FutureProvider<Insights>`

Notifications — `features/notifications/application/notifications_controller.dart`
- `notificationsControllerProvider` → `AsyncNotifierProvider<_, List<AppNotification>>`
  - methods: `.refresh()`, `.markRead(id, {read})`, `.markAllRead()`
- `unreadNotificationsCountProvider` → `Provider<int>`

Settings — `features/settings/application/theme_controller.dart`
- `themeModeControllerProvider` → `NotifierProvider<_, ThemeMode>`; method `.set(ThemeMode)`
- `localeControllerProvider` → `NotifierProvider<_, Locale?>`; method `.set(Locale?)`

## Shared widgets — `lib/shared/widgets/`

- `AsyncValueView<T>(value: asyncValue, data: (T)=>Widget, loading: Widget?, onRetry: VoidCallback?)`
- `ListSkeleton(itemCount)`, `Shimmer(child)`, `SkeletonBox(width,height,radius)` — for custom loaders
- `ErrorView(error, onRetry)`, `EmptyView(icon, title, message, action)`
- `SectionHeader(title, actionLabel, onAction)`
- `TransactionTile(transaction, onTap, showDate)`
- `CreditCardWidget(card, balanceLabel, onTap, heroTag)`  — renders a BankCard
- `MaxWidthBody(child, maxWidth)`  — centers/limits width on large screens
- `CategoryVisual visualForCategory(String category)` → `{ IconData icon; Color color; String label }`
  and `String categoryLabel(String)` from `category_visuals.dart`

## Formatters — `core/utils/formatters.dart` (static)
- `Formatters.money(amount, currencyCode)` → "$8,240.55"
- `Formatters.signedMoney(amount, code)` → "+$12.00" / "-$9.99"
- `Formatters.compactMoney(amount, code)` → "$12.5K"
- `Formatters.date(dt)`, `Formatters.dateTime(dt)`, `Formatters.dayMonth(dt)`, `Formatters.relativeDay(dt)`

## Routes — `core/router/app_routes.dart` (`AppRoutes`)
`splash, onboarding, login, register, forgotPassword, dashboard('/'), transactions, cards,
insights, settings, transfer, notifications, addCard`, plus
`AppRoutes.transactionDetail(id)`, `AppRoutes.cardDetail(id)`.

## fl_chart note
fl_chart is **^1.2.0**. Use `PieChart(PieChartData(sections: [PieChartSectionData(...)]))`,
`LineChart(LineChartData(...))`, `BarChart(BarChartData(...))`. Wrap charts in a fixed-height box.
