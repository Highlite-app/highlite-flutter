import 'package:flutter/material.dart';

// Assuming correct paths for imports.
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class CustomAutocomplete extends StatefulWidget {
  final List<String> options;
  final String hintText;
  final IconData icon;
  final void Function(String)? onSelected;

  const CustomAutocomplete({
    Key? key,
    required this.options,
    this.hintText = 'Search',
    this.icon = Icons.search,
    this.onSelected,
  }) : super(key: key);

  @override
  _CustomAutocompleteState createState() => _CustomAutocompleteState();
}

class _CustomAutocompleteState extends State<CustomAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  bool isOpen  = true ;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return widget.options.where(
          (option) => option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        textEditingController
          ..text = _controller.text
          ..selection = _controller.selection;
        _controller.addListener(() {
          textEditingController.text = _controller.text;
        });
        return TextField(
          controller: _controller,
          focusNode: focusNode,
          onChanged: (value){
            setState(() {
              if(value.isNotEmpty && !isOpen){
                isOpen = true ;
              }
            });
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.neutral400)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.neutral400)),
            prefixIcon: Icon(widget.icon),
            hintText: widget.hintText,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.neutral400)),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        String query = _controller.text.toLowerCase();
        return isOpen ? Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            elevation: 4.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final String option = options.elementAt(index);
                int startIndex = option.toLowerCase().indexOf(query);
                int endIndex = startIndex + query.length;

                return ListTile(
                  title: startIndex >= 0 && query.isNotEmpty
                      ? RichText(
                          text: TextSpan(
                            style: TextStyle(color: ColorConstant.neutral900),
                            // Default text style
                            children: [
                              TextSpan(text: option.substring(0, startIndex)),
                              TextSpan(
                                text: option.substring(startIndex, endIndex),
                                style: TextStyle(
                                    backgroundColor: ColorConstant.neutral600,
                                    color: Colors.white),
                              ),
                              TextSpan(text: option.substring(endIndex)),
                            ],
                          ),
                        )
                      : Text(
                          option,
                          style: BaseTextStyle(
                              color: ColorConstant.neutral900,
                              fontSize: TypographyTheme.paragraph_p3),
                        ),
                  onTap: () {
                    setState(() {
                      isOpen = !isOpen ;
                      _controller.text = option;
                      _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length),
                      );
                      if (widget.onSelected != null) {
                        widget.onSelected!(option);
                      }
                    });

                  },
                );
              },
            ),
          ),
        ): const Offstage();
      },
      onSelected: (selectedOption) {
        if (widget.onSelected != null) {
          widget.onSelected!(selectedOption);
        }
      },
    );
  }
}
