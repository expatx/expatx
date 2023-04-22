import 'package:expatx/core/app_colors.dart';
import 'package:flutter/material.dart';

class CreatePostLanguageDropdown extends StatefulWidget {
  const CreatePostLanguageDropdown({super.key});

  @override
  CreatePostLanguageDropdownState createState() =>
      CreatePostLanguageDropdownState();
}

class CreatePostLanguageDropdownState
    extends State<CreatePostLanguageDropdown> {
  //String _bankChoose;
  late LanguageListDataModel _chosenLanguage;

  List<LanguageListDataModel> languageDataList = [
    LanguageListDataModel(
      "What language is this?",
    ),
    LanguageListDataModel(
      "English",
    ),
    LanguageListDataModel(
      "Spanish",
    ),
    LanguageListDataModel(
      "French",
    ),
  ];
  @override
  void initState() {
    super.initState();
    _chosenLanguage = languageDataList[0];
  }

  void _onDropDownItemSelected(LanguageListDataModel newSelectedBank) {
    setState(() {
      _chosenLanguage = newSelectedBank;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.expatxPurple,
          ),
          child: SizedBox(
            height: 47,
            width: 245,
            // margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    fillColor: AppColors.expatxPurple,
                    filled: true,
                    focusColor: Colors.blue,
                    contentPadding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    // errorText: "Wrong Choice",
                    // errorStyle: const TextStyle(
                    //     color: Colors.redAccent, fontSize: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<LanguageListDataModel>(
                      borderRadius: BorderRadius.circular(25),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Roboto",
                      ),
                      // iconSize: 35,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      hint: const Text(
                        "Select Language",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "Roboto",
                        ),
                      ),
                      items: languageDataList
                          .map<DropdownMenuItem<LanguageListDataModel>>(
                              (LanguageListDataModel value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Row(
                            children: [
                              value.languageName == "What language is this?"
                                  ? const SizedBox.shrink()
                                  : const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                              // CircleAvatar(
                              //   backgroundImage: NetworkImage(value.languageLogo),
                              // ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(value.languageName),
                            ],
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                      isDense: true,
                      onChanged: (LanguageListDataModel? newSelectedBank) {
                        _onDropDownItemSelected(newSelectedBank!);
                      },
                      value: _chosenLanguage,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageListDataModel {
  String languageName;

  LanguageListDataModel(this.languageName);
}
