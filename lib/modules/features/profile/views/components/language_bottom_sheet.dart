import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/localization/localization.dart';
import 'package:trainee/modules/features/profile/views/components/locale_card.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Rx<Locale> selectedLocale = Rx<Locale>(Localization.currentLocale);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpacingRadius,
          Text(
            'Change language'.tr,
            style: Get.textTheme.headlineSmall,
          ),
          16.verticalSpacingRadius,
          Wrap(
            spacing: 12.r,
            runSpacing: 12.r,
            children: List.generate(
              Localization.langs.length,
              (index) => LocaleCard(
                isSelected: selectedLocale.value == Localization.locales[index],
                flag: Localization.flags[index],
                language: Localization.langs[index],
                onTap: () {
                  selectedLocale(Localization.locales[index]);
                  Get.back(result: Localization.langs[index]);
                },
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
