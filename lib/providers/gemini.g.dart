// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseApp)
final firebaseAppProvider = FirebaseAppProvider._();

final class FirebaseAppProvider
    extends
        $FunctionalProvider<
          AsyncValue<FirebaseApp>,
          FirebaseApp,
          FutureOr<FirebaseApp>
        >
    with $FutureModifier<FirebaseApp>, $FutureProvider<FirebaseApp> {
  FirebaseAppProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAppProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAppHash();

  @$internal
  @override
  $FutureProviderElement<FirebaseApp> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FirebaseApp> create(Ref ref) {
    return firebaseApp(ref);
  }
}

String _$firebaseAppHash() => r'9fd2bd65dbca1d621d366b0bae8a2966a610773e';

@ProviderFor(geminiModel)
final geminiModelProvider = GeminiModelProvider._();

final class GeminiModelProvider
    extends
        $FunctionalProvider<
          AsyncValue<GenerativeModel>,
          GenerativeModel,
          FutureOr<GenerativeModel>
        >
    with $FutureModifier<GenerativeModel>, $FutureProvider<GenerativeModel> {
  GeminiModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geminiModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geminiModelHash();

  @$internal
  @override
  $FutureProviderElement<GenerativeModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GenerativeModel> create(Ref ref) {
    return geminiModel(ref);
  }
}

String _$geminiModelHash() => r'c5fbacdc9690aee84c4f3b57da5d4d4738fb1a70';

@ProviderFor(chatSession)
final chatSessionProvider = ChatSessionProvider._();

final class ChatSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<ChatSession>,
          ChatSession,
          FutureOr<ChatSession>
        >
    with $FutureModifier<ChatSession>, $FutureProvider<ChatSession> {
  ChatSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatSessionHash();

  @$internal
  @override
  $FutureProviderElement<ChatSession> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChatSession> create(Ref ref) {
    return chatSession(ref);
  }
}

String _$chatSessionHash() => r'fdd5e4ed9d06db9712c9300eeb8a1b54a115b10a';
