import 'package:material_ui/material_ui.dart';
import 'package:colorist_ui/colorist_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- Importante
import 'firebase_options.dart'; // <-- Archivo generado por firebase configure
import 'providers/gemini.dart';
import 'services/gemini_chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializamos Firebase antes de arrancar la app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(geminiModelProvider);
    final conversationState = ref.watch(conversationStateProvider);

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: model.when(
        data: (data) => MainScreen(
          conversationState: conversationState,
          notifyColorSelection: (color) {
            ref.read(geminiChatServiceProvider).notifyColorSelection(color);
          },
          sendMessage: (text) {
            ref.read(geminiChatServiceProvider).sendMessage(text);
          },
        ),
        loading: () => const LoadingScreen(message: 'Initializing Gemini Model'),
        error: (err, st) => ErrorScreen(error: err),
      ),
    );
  }
}
