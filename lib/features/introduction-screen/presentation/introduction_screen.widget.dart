import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/core/presentation/constants/offset.constants.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/core/presentation/shared/image_select_item/image_select_item.dart';
import 'package:game_box/features/introduction-screen/presentation/widgets/introduction.widget.dart';
import 'package:game_box/features/localization/domain/bloc/localization.bloc.dart';
import 'package:game_box/features/localization/domain/bloc/localization.state.dart';
import 'package:game_box/features/localization/presentation/localization_list.dart';
import 'package:game_box/generated/locale_keys.g.dart';
import 'package:game_box/routing/enums/routing.enum.dart';

import 'widgets/introduction_screen_card.widget.dart';

class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({super.key});

  final _introductionScreenKey = GlobalKey<IntroductionState>();

  void _moveNext() {
    _introductionScreenKey.currentState?.moveToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.watch<ThemeBloc>().state.theme.background,
      child: Introduction(
        key: _introductionScreenKey,
        pages: [
          IntroductionScreenCard(
            buttonText: 'Next',
            imgPath: 'assets/images/welcome3.png',
            body: Column(
              children: [
                const SizedBox(
                  height: OffsetConstants.m,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    LocaleKeys.introduce.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.read<ThemeBloc>().state.theme.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            onButtonTap: _moveNext,
          ),
          IntroductionScreenCard(
              buttonText: 'Next',
              imgPath: 'assets/images/welcome2.png',
              onButtonTap: _moveNext,
              body: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: BlocBuilder<LocalizationBloc, LocalizationState>(builder: (context, state) {
                  return LocalizationList(
                    localization: state.locale ?? LocaleEnum.eng,
                  );
                }),
              )),
          IntroductionScreenCard(
            buttonText: 'Start',
            imgPath: 'assets/images/gameBox.png',
            body: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.choose_game.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.read<ThemeBloc>().state.theme.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: OffsetConstants.m),
                  ImageSelectItem(
                    imgPath: 'assets/images/tetris.png',
                    text: 'Tetris',
                    isSelected: false,
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutingEnum.tetris.name);
                    },
                  ),
                ],
              ),
            ),
            onButtonTap: () => Navigator.of(context).pushNamed(RoutingEnum.tetris.name),
          ),
        ],
      ),
    );
  }
}
