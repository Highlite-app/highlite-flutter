import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import '../../presentation/widgets/buttons/selection_view.dart';
import '../../presentation/widgets/chat/chat_responder.dart';

class DefaultChatResponders {
  static Future<ChatRespondent> name(FocusNode focusNode) => Future.value(
        ChatRespondent(
          input: true,
          minMaxLines: MinMax(1, 6),
          focusNode: focusNode,
          keyboardType: TextInputType.name,
        ),
      );
  //
  // static Future<ChatRespondent> countryCode(FocusNode focusNode) async {
  //   final countryCodes = await CountryCodes.countryCodes();
  //   return ChatRespondent(
  //     options: countryCodes
  //         .map(
  //           (code) => Selection(
  //             text: "${code.name} (${code.dialCode})",
  //             icon: code.code,
  //             isFlagIcon: true,
  //           ),
  //         )
  //         .toList(),
  //     searchable: true,
  //     capitalize: false,
  //   );
  // }

  static Future<ChatRespondent> phoneNumber(FocusNode focusNode) =>
      Future.value(
        ChatRespondent(

          input: true,
          focusNode: focusNode,
          keyboardType: TextInputType.phone,
        ),
      );

  static Future<ChatRespondent> otp(FocusNode focusNode) => Future.value(
        ChatRespondent(
          input: true,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
        ),
      );
  static Future<ChatRespondent> otpWithTryAgainFlow(FocusNode focusNode) =>
      Future.value(
        ChatRespondent(
          options: [
            Selection(text: TranslationKeys.didntReceiveCode),
          ],
          capitalize: true,
          input: true,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
        ),
      );

  static Future<ChatRespondent> email(FocusNode focusNode) => Future.value(
        ChatRespondent(
          input: true,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
          inputType: InputType.normal,
        ),
      );

  static Future<ChatRespondent> anyText(FocusNode focusNode) => Future.value(
        ChatRespondent(
          input: true,
          focusNode: focusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        ),
      );
}
