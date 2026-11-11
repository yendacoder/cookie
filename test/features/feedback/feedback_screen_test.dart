import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/features/feedback/providers/feedback_provider.dart';
import 'package:cookie/features/feedback/screens/feedback_screen.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class _MockFeedbackService extends Mock implements FeedbackService {}

void main() {
  late _MockFeedbackService service;

  setUp(() {
    service = _MockFeedbackService();
    when(() => service.diagnostics).thenReturn(const {'version': '1.0.0'});
  });

  late GoRouter router;
  var config = const FeedbackConfig(
    endpoint: 'https://feedback.example.com/v1/feedback',
    supportEmail: 'support@example.com',
  );

  Widget app() {
    return ProviderScope(
      overrides: [
        platformStyleProvider.overrideWithValue(PlatformStyle.android),
        feedbackConfigProvider.overrideWithValue(config),
        feedbackServiceProvider.overrideWithValue(service),
        feedbackDiagnosticsProvider.overrideWithValue(const {
          'version': '1.0.0',
        }),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  /// Pumps the app on '/' and pushes the feedback screen so it can pop.
  Future<void> pumpApp(WidgetTester tester) async {
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: Text('home')),
        ),
        GoRoute(path: '/feedback', builder: (_, _) => const FeedbackScreen()),
      ],
    );
    await tester.pumpWidget(app());
    router.push('/feedback');
    await tester.pumpAndSettle();
  }

  Finder sendButton() => find.widgetWithText(TextButton, 'Send');
  Finder messageField() => find.widgetWithText(TextField, 'Message');
  Finder emailField() =>
      find.widgetWithText(TextField, 'Your email (optional)');

  void stubSend(Future<void> Function() answer) => when(
    () => service.send(
      category: any(named: 'category'),
      message: any(named: 'message'),
      email: any(named: 'email'),
      includeDiagnostics: any(named: 'includeDiagnostics'),
    ),
  ).thenAnswer((_) => answer());

  setUpAll(() => registerFallbackValue(FeedbackCategory.bug));

  testWidgets('send is disabled until a message is entered', (tester) async {
    await pumpApp(tester);

    expect(tester.widget<TextButton>(sendButton()).onPressed, isNull);
    await tester.enterText(messageField(), 'Hello');
    await tester.pump();
    expect(tester.widget<TextButton>(sendButton()).onPressed, isNotNull);
  });

  testWidgets('invalid email blocks sending', (tester) async {
    await pumpApp(tester);

    await tester.enterText(messageField(), 'Hello');
    await tester.enterText(emailField(), 'not-an-email');
    await tester.tap(sendButton());
    await tester.pump();

    expect(find.text('Enter a valid email address'), findsOneWidget);
    verifyNever(
      () => service.send(
        category: any(named: 'category'),
        message: any(named: 'message'),
        email: any(named: 'email'),
        includeDiagnostics: any(named: 'includeDiagnostics'),
      ),
    );
  });

  testWidgets('sends selected category and pops on success', (tester) async {
    stubSend(() async {});
    await pumpApp(tester);

    await tester.tap(find.text('Content concern'));
    await tester.enterText(messageField(), 'Spam');
    await tester.pump();
    await tester.tap(find.byType(Switch));
    await tester.pump();
    await tester.tap(sendButton());
    await tester.pumpAndSettle();

    verify(
      () => service.send(
        category: .content,
        message: 'Spam',
        email: '',
        includeDiagnostics: false,
      ),
    ).called(1);
    expect(find.text('home'), findsOneWidget);
    expect(find.text('Thanks! Your feedback has been sent.'), findsOneWidget);
  });

  testWidgets('stays on screen and shows error on failure', (tester) async {
    stubSend(() => Future.error(const FeedbackException(.failed)));
    await pumpApp(tester);

    await tester.enterText(messageField(), 'Hello');
    await tester.pump();
    await tester.tap(sendButton());
    await tester.pumpAndSettle();

    expect(find.byType(FeedbackScreen), findsOneWidget);
    expect(
      find.text(
        "Couldn't send feedback. Please try again or email support@example.com.",
      ),
      findsOneWidget,
    );
    expect(tester.widget<TextButton>(sendButton()).onPressed, isNotNull);
  });

  testWidgets('hides email fallback when no support email is set', (
    tester,
  ) async {
    config = const FeedbackConfig(endpoint: 'https://feedback.example.com');
    addTearDown(
      () => config = const FeedbackConfig(
        endpoint: 'https://feedback.example.com/v1/feedback',
        supportEmail: 'support@example.com',
      ),
    );
    stubSend(() => Future.error(const FeedbackException(.failed)));
    await pumpApp(tester);

    expect(find.textContaining('Prefer email?'), findsNothing);
    await tester.enterText(messageField(), 'Hello');
    await tester.pump();
    await tester.tap(sendButton());
    await tester.pumpAndSettle();
    expect(
      find.text("Couldn't send feedback. Please try again later."),
      findsOneWidget,
    );
  });
}
