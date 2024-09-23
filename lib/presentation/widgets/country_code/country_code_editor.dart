import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboarding/country_city.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../form/search_field.dart';
import '../navigation/navigated_page.dart';
import '../svg/flag_icon.dart';
import '../utils/country_codes.dart';

class CountryCodeEditorPage extends StatefulWidget {
  const CountryCodeEditorPage({super.key});

  @override
  State<CountryCodeEditorPage> createState() => _CountryCodeEditorPageState();
}

class _CountryCodeEditorPageState extends State<CountryCodeEditorPage> {
  TextEditingController controller = TextEditingController();
  String searchQuery = "";
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<List<CountryCode>> _loadCountries() async {
    return CountryCodes.countryCodes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadCountries(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final searchedCountries = searchQuery == ""
            ? snapshot.data!.toList()
            : snapshot.data!
                .where((e) =>
                    e.name.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();
        return NavigatedPage(
          title: "Select your country",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SearchField(
                  focusNode: FocusNode(),
                  controller: controller,
                  borderRadius: 8.0,
                  onTextChanged: (value){
                    setState(() {
                      searchQuery = value ;
                    });
                    }),
            
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchedCountries.length,
                    itemBuilder: (context, index) => Rippler(
                      onTap: () {
                        context.navigator.pop(searchedCountries[index]);
                      },
                      child: ListTile(
                        leading: FlagIcon(
                          country: searchedCountries[index].code,
                        ),
                        title: Text(
                          "${searchedCountries[index].name} (${searchedCountries[index].dialCode})",
                          style:  BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p3,
                            color: ColorConstant.neutral800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
