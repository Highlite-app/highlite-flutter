import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboarding/country_city.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/country_code/country_code_editor.dart';
import '../../widgets/drawer/content/content_subpage.dart';
import '../../widgets/svg/flag_icon.dart';
import '../../widgets/text_field/primary_field.dart';

class PhoneNumberSubpage extends StatefulWidget {
  const PhoneNumberSubpage({super.key});

  @override
  State<PhoneNumberSubpage> createState() => _PhoneNumberSubpageState();
}

class _PhoneNumberSubpageState extends State<PhoneNumberSubpage> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  CountryCode? code;

  @override
  void initState() {
    super.initState();
    phoneNumber.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    countryCode.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      title: "Change phone number",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your phone number to continue",
              textAlign: TextAlign.center,
              style: BaseTextStyle(
                  color: ColorConstant.neutral900,
                  fontSize: TypographyTheme.heading_H6,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        PrimaryFieldContainer(
          children: [
            PrimaryField(
              placeholderText: "Select your country",
              label: "Country/Region",
              focus: FocusNode(),
              controller: countryCode,
              editable: false,
              onTap: () {
                context.navigator
                    .push<CountryCode>(
                  MaterialPageRoute(
                    builder: (_) => const CountryCodeEditorPage(),
                  ),
                )
                    .then((value) {
                  setState(() {
                    if (value != null) {
                      code = value;
                      countryCode.text = "${code!.name}(${code!.dialCode})";
                    }
                  });
                });
              },
              prefix: FlagIcon(country: code != null ? code!.code : "US"),
            ),
            PrimaryField(
              placeholderText: "000-000-0000",
              label: "Enter Phone Number",
              formatter: [MaskedInputFormatter('###-###-####')],
              focus: FocusNode(),
              controller: phoneNumber,
              topBorder: true,
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        PrimaryButton(
          title: "Continue",
          onTap: code != null && phoneNumber.text != ""
              ? () {
                  // final label = "${code!.dialCode}-${phoneNumber.text}";
                  // context.read<SettingsBloc>().add(SendOTPForChange(
                  //     sendTo:
                  //         phoneNumberString(code!.dialCode, phoneNumber.text),
                  //     signInOption: SignInOption.phoneNumber));
                  // context.navigator.push<bool>(
                  //   MaterialPageRoute(
                  //     builder: (_) => OTPSubpage(
                  //       title: "Change phone number",
                  //       label: label,
                  //       targetChange: "phone number",
                  //     ),
                  //   ),
                  // );
                }
              : null,
          horizontalPadding: 0,
        ),
      ],
    );
  }
}
