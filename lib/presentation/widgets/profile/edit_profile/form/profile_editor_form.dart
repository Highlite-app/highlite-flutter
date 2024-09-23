import 'package:flutter/material.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../utils/context.dart';
import '../../../form/form.dart';
import '../../../navigation/navigated_page.dart';
import '../../edit_profile_button_stack.dart';

class EditorFormModel<DataModel> {
  final String title;
  final List<Widget> Function(DataModel?)? sliverChildren;
  final List<Widget> Function(
          DataModel?, ValueNotifier<FormProviderState>, Function(Function()))
      children;
  final List<Widget> Function(
          DataModel?, ValueNotifier<FormProviderState>, Function(Function()))?
      afterChildren;
  final Future<void> Function(DataModel?, BuildContext) onComplete;
  final bool Function() validated;
  final bool buttonsEnabled;
  const EditorFormModel({
    required this.title,
    this.sliverChildren,
    required this.children,
    required this.onComplete,
    this.afterChildren,
    required this.validated,
    this.buttonsEnabled = true,
  });
}

class ProfileEditorForm<DataModel> extends StatefulWidget {
  final EditorFormModel<DataModel> form;
  final DataModel? data;

  const ProfileEditorForm({
    super.key,
    required this.form,
    required this.data,
  });

  @override
  State<ProfileEditorForm<DataModel>> createState() =>
      _ProfileEditorFormState<DataModel>();
}

class _ProfileEditorFormState<DataModel>
    extends State<ProfileEditorForm<DataModel>> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<FormProviderState> formState =
      ValueNotifier(FormProviderState.empty);

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: widget.form.title,
      includesBorder: true,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorConstant.shade00,
        ),
        child: Padding(
          padding: widget.form.sliverChildren != null
              ? const EdgeInsets.only(top: 2.0)
              : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: FormProvider(
            formKey: _formKey,
            formState: formState,
            builder: (formState) => widget.form.sliverChildren != null
                ? CustomScrollView(
                    slivers: widget.form.sliverChildren!(widget.data),
                  )
                : _normalChildren(),
          ),
        ),
      ),
    );
  }

  Widget _normalChildren() {
    return Column(
      children: [
        ...widget.form.children(widget.data, formState, setState).map(
              (e) => Column(
                children: [
                  e,
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
        if (widget.form.buttonsEnabled)
          EditProfileButtonStack(
            isRequestButton: false,
            cancelAction: () {
              context.navigator.pop(context);
            },
            saveAction: () {
              formState.value = FormProviderState.submitted;
              if (_formKey.currentState!.validate() &&
                  widget.form.validated()) {
                widget.form.onComplete(widget.data, context);
                context.navigator.pop(context);
              }
            },
          ),
        const SizedBox(height: 16.0),
        if (widget.form.afterChildren != null)
          ...widget.form.afterChildren!(widget.data, formState, setState)
      ],
    );
  }
}
