import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';
import '../screens/screens.dart';

class CountryListTile extends ConsumerWidget {
  CountryListTile({
    required this.countryFlagUrl,
    required this.countryName,
    required this.countryNameShort,
    super.key,
  });

  String countryName;
  String countryNameShort;
  String countryFlagUrl;

  @override
  Widget build(BuildContext context, ref) {
    final selectedCountry = ref.watch(selectedCountryProvider);

    return GestureDetector(
      onTap: () {
        ref.read(selectedCountryProvider.notifier).state = countryNameShort;
        ref.read(selectedCountryNameProvider.notifier).state = countryName;
        ref.read(selectedCountryFlagProvider.notifier).state = countryFlagUrl;
        ref.read(selectedCountryShortNameProvider.notifier).state =
            countryNameShort;
        Navigator.pop(context);
      },
      child: Container(
        height: 64.h,
        width: 327.w,
        decoration: BoxDecoration(
          color: textFieldColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(countryFlagUrl),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    countryNameShort,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w500, color: darkGrey),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(countryName,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: buttonColor)),
                ],
              ),
              if (selectedCountry == countryNameShort)
                SvgPicture.asset('assets/countrycheck.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
