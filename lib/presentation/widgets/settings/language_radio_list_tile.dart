import 'package:flutter/material.dart';

class LanguageRadioListTile extends StatelessWidget {
  final int selectedLanguage; // The currently selected language index
  final String languageNames; // The name of the language
  final String codes; // The code of the language
  final int value; // The index of the language
  final Function(int?) onChanged;

  const LanguageRadioListTile({
    super.key,
    required this.selectedLanguage,
    required this.languageNames,
    required this.codes,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(languageNames),
      subtitle: Text(codes),
      groupValue: selectedLanguage,
      value: value,
      onChanged: onChanged,
    );
  }
}
