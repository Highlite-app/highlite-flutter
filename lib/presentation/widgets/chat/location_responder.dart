import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';


import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboarding/country_city.dart';
import '../constants/text_style.dart';
import 'chat_input.dart';
import 'chat_responder.dart';

class LocationResponder extends StatefulWidget {
  final ChatRespondent chatRespondent;
  final Function onPress;
  const LocationResponder({
    super.key,
    required this.chatRespondent,
    required this.onPress,
  });

  @override
  State<LocationResponder> createState() => _LocationResponderState();
}

class _LocationResponderState extends State<LocationResponder> {
  FocusNode focusNode = FocusNode();
  bool visibleList = false;
  bool _loadedInitData = false;
  final int _perPage = 200;
  List<CountryCity> countries = [];
  List<CountryCity> displayedCountries = [];
  String searchQuery = "";
  ScrollController scrollController = ScrollController();
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      _onLoadView();
      _loadedInitData = true;
      focusNode.addListener(() {
        setState(() {
          visibleList = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        _paginate(displayedCountries.length - 1);
      }
    });
    super.initState();
  }

  Future<void> _onLoadView() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/countries.min.json");
    final Map<String, dynamic> jsonResult = jsonDecode(data);
    List<CountryCity> countries = [];
    jsonResult.forEach((key, value) {
      final data = (jsonResult[key] as List).map((e) => e as String).toList();
      for (var element in data) {
        countries.add(CountryCity(country: key, city: element));
      }
    });
    this.countries = countries;
    _paginate(0);
  }

  _paginate(int startIndex) {
    setState(() {
      if (searchQuery == "") {
        displayedCountries.addAll(
            countries.getRange(startIndex, startIndex + _perPage).toList());
      } else {
        displayedCountries = countries
            .where((e) =>
                e.country.toLowerCase().contains(searchQuery.toLowerCase()))
            .toSet()
            .toList();
      }
    });
  }

  _search(String query) {
    searchQuery = query;
    if (searchQuery == "") {
      setState(() {
        displayedCountries = [];
      });
      _paginate(0);
    } else {
      setState(() {
        List<CountryCity> fetchedCountries = countries
            .where((e) =>
                e.country.toLowerCase().contains(searchQuery.toLowerCase()))
            .toSet()
            .toList();
        if (fetchedCountries.isNotEmpty) {
          int length = _perPage;
          if (length > fetchedCountries.length) {
            length = fetchedCountries.length;
          }
          displayedCountries =
              fetchedCountries.getRange(0, length - 1).toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 0),
          child: ChatInput(
            initialValue: "",
            placeholderText: "location",
            sendMessage: null,
            onChange: (message) {
              _search(message);
            },
            sendAttachments: (attachments) {},
            sendFile: (file) {},
            focusNode: focusNode,
            keyboardType: widget.chatRespondent.keyboardType!,
            sendButtonEnabled: false,
            searchEnabled: true,
            clearEnabled: true,
            inputType: InputType.normal,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.only(bottom: 20.0),
                shrinkWrap: true,
                itemCount: displayedCountries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.onPress(displayedCountries[index]);
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading:  const ImageIcon(
                              AssetImage(AssetConstant.markerPinIcon),
                              color: ColorConstant.neutral800,
                              size: 30,
                            ),
                            title: Text(
                              displayedCountries[index].city.toString(),
                              style:  BaseTextStyle(
                                  fontSize: TypographyTheme.paragraph_p3,
                                  color: ColorConstant.neutral700,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              displayedCountries[index].country.toString(),
                              style:  BaseTextStyle(
                                  fontSize: TypographyTheme.paragraph_p3,
                                  color: ColorConstant.neutral700),
                            ),
                          ),
                           Divider(
                            height: 1,
                            color: ColorConstant.neutral500,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
