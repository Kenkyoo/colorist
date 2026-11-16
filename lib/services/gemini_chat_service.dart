import 'dart:async';

import 'package:colorist_ui/colorist_ui.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/gemini.dart';
import 'gemini_tools.dart';

part 'gemini_chat_service.g.dart';

class ConversationStateNotifier extends Notifier<ConversationState> {
  // Add from here...
  @override
  ConversationState build() => ConversationState.idle;

  void busy() {
    state = ConversationState.busy;
  }

  void idle() {
    state = ConversationState.idle;
  }
}

final conversationStateProvider =
    NotifierProvider<ConversationStateNotifier, ConversationState>(
      ConversationStateNotifier.new,
    ); // To here.

class GeminiChatService {
  GeminiChatService(this.ref);
  final Ref ref;

  Future<void> sendMessage(String message) async {
    final chatSession = await ref.read(chatSessionProvider.future);
    final conversationState = ref.read(
      conversationStateProvider,
    ); // Add this line
    final chatStateNotifier = ref.read(chatStateProvider.notifier);
    final logStateNotifier = ref.read(logStateProvider.notifier);

    if (conversationState == ConversationState.busy) {
      // Add from here...
      logStateNotifier.logWarning(
        "Can't send a message while a conversation is in progress",
      );
      throw Exception(
        "Can't send a message while a conversation is in progress",
      );
    }
    final conversationStateNotifier = ref.read(
      conversationStateProvider.notifier,
    );
    conversationStateNotifier.busy(); // To here.
    chatStateNotifier.addUserMessage(message);
    logStateNotifier.logUserText(message);
    final llmMessage = chatStateNotifier.createLlmMessage();
    try {
      // Modify from here...
      final responseStream = chatSession.sendMessageStream(
        Content.text(message),
      );
      await for (final block in responseStream) {
        await _processBlock(block, llmMessage.id);
      } // To here.
    } catch (e, st) {
      logStateNotifier.logError(e, st: st);
      chatStateNotifier.appendToMessage(
        llmMessage.id,
        "\nI'm sorry, I encountered an error processing your request. "
        "Please try again.",
      );
    } finally {
      chatStateNotifier.finalizeMessage(llmMessage.id);
      conversationStateNotifier.idle(); // Add this line.
    }
  }

  Future<void> _processBlock(
    // Add from here...
    GenerateContentResponse block,
    String llmMessageId,
  ) async {
    final chatSession = await ref.read(chatSessionProvider.future);
    final chatStateNotifier = ref.read(chatStateProvider.notifier);
    final logStateNotifier = ref.read(logStateProvider.notifier);
    final blockText = block.text;
    if (blockText != null) {
      logStateNotifier.logLlmText(blockText);
      chatStateNotifier.appendToMessage(llmMessageId, blockText);
    }

    if (block.functionCalls.isNotEmpty) {
      final geminiTools = ref.read(geminiToolsProvider);
      final responseStream = chatSession.sendMessageStream(
        Content.functionResponses([
          for (final functionCall in block.functionCalls)
            FunctionResponse(
              functionCall.name,
              geminiTools.handleFunctionCall(
                functionCall.name,
                functionCall.args,
              ),
            ),
        ]),
      );
      await for (final response in responseStream) {
        final responseText = response.text;
        if (responseText != null) {
          logStateNotifier.logLlmText(responseText);
          chatStateNotifier.appendToMessage(llmMessageId, responseText);
        }
      }
    }
  } // To here.
}

@Riverpod(keepAlive: true)
GeminiChatService geminiChatService(Ref ref) => GeminiChatService(ref);
