import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/edit_profile/form/profile_editor_form_item.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_event.dart';
import '../../../../form/tags_selection.dart';
import '../../form/profile_editor_form.dart';

class EditCompanyProfileBenefits extends EditorFormModel<CompanyOnboarding> {
  EditCompanyProfileBenefits({required List<String> companyBenefits})
      : super(
          title: TranslationKeys.editCompanyBenefits,
          children: (company, formState, setState) => [
            ProfileEditorFormItem(
              label: TranslationKeys.companyBenefits,
              padded: false,
              children: TagsSelection(
                title: TranslationKeys.benefits,
                selection: companyBenefits,
                onSelect: (selectedSkills) {
                  setState(() {
                    companyBenefits = selectedSkills;
                  });
                },
                maxCount: 3,
              ),
            ),
          ],
          onComplete: (companyProfile, context) async {
            context.read<CompanyEditorBloc>().add(
                  UpdateCompanyEvent(
                    companyProfile: companyProfile!.copyWith(
                      benefits: companyBenefits,
                    ),
                  ),
                );
          },
          validated: () => true,
        );
}
