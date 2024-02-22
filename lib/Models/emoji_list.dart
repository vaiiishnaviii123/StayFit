import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmojiList{

 static Map<String, String> getList(BuildContext context){
     final Map<String, String> emojiExpressionsSpanish = {
      "😀": "${AppLocalizations.of(context)!.emoji1}",
      "😋": "${AppLocalizations.of(context)!.emoji2}",
      "🥰": "${AppLocalizations.of(context)!.emoji3}",
      "🤣": "${AppLocalizations.of(context)!.emoji4}",
      "😇": "${AppLocalizations.of(context)!.emoji5}",
      "😊": "${AppLocalizations.of(context)!.emoji6}",
      "😎": "${AppLocalizations.of(context)!.emoji7}",
      "🤗": "${AppLocalizations.of(context)!.emoji8}",
      "🥳": "${AppLocalizations.of(context)!.emoji9}",
      "🤩": "${AppLocalizations.of(context)!.emoji10}",
      "🤔": "${AppLocalizations.of(context)!.emoji11}",
      "😏": "${AppLocalizations.of(context)!.emoji12}",
      "🤬": "${AppLocalizations.of(context)!.emoji13}",
      "😠": "${AppLocalizations.of(context)!.emoji14}",
      "🤐": "${AppLocalizations.of(context)!.emoji15}",
      "🤢": "${AppLocalizations.of(context)!.emoji16}",
      "🤕": "${AppLocalizations.of(context)!.emoji17}",
      "😞": "${AppLocalizations.of(context)!.emoji18} ",
      "😥": "${AppLocalizations.of(context)!.emoji19}",
      "🥱": "${AppLocalizations.of(context)!.emoji20}",
      "😴": "${AppLocalizations.of(context)!.emoji21}",
      "😭": "${AppLocalizations.of(context)!.emoji22}",
      "🙄": "${AppLocalizations.of(context)!.emoji23}",
      "😯": "${AppLocalizations.of(context)!.emoji24}",
      "🤯": "${AppLocalizations.of(context)!.emoji25}",
    };
    return emojiExpressionsSpanish;
  }
}