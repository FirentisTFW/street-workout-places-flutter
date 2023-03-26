import 'package:app/common/root_navigator.dart';
import 'package:app/extensions/extensions.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/routing/dashboard_tabs/form_routing.dart';
import 'package:app/styles/app_padding.dart';
import 'package:app/styles/app_text_styles.dart';
import 'package:app/widgets/primary_button.dart';
import 'package:app/widgets/space.dart';
import 'package:flutter/material.dart';

class NewSpotInitialPage extends StatelessWidget {
  const NewSpotInitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.defaultAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).newSpotInitialHeader.toUpperCase(),
              style: AppTextStyles.titleBig(),
            ),
            _buildIcon(),
            Padding(
              padding: AppPadding.defaultHorizontal,
              child: Text(
                S.of(context).newSpotInitialDescription,
                style: AppTextStyles.contentBiggerMultiline(),
                textAlign: TextAlign.center,
              ),
            ),
            _buildNextButton(context),
          ].separatedBy(
            const Space.vertical(20.0),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    // TODO Replace icon
    return const Icon(
      Icons.accessibility_new_outlined,
      size: 200.0,
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return PrimaryButton(
      S.of(context).newSpotInitialNextButtonTitle,
      onPressed: () => RootNavigator.of(context).pushNamed(FormRouting.form),
    );
  }
}
