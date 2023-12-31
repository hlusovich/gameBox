import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.events.dart';
import 'package:game_box/core/domain/bloc/theme/theme.state.dart';
import 'package:game_box/core/presentation/theme/app_dark_theme.dart';
import 'package:game_box/core/presentation/theme/app_light_theme.dart';
import 'package:game_box/core/presentation/theme/enums/theme.enum.dart';

class ThemeBloc extends Bloc<ThemeEvents, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: LightTheme())) {
    on<ChangeTheme>(onChangeTheme);
  }

  ThemeEnum get theme => state.theme is LightTheme ? ThemeEnum.light : ThemeEnum.dark;

  void onChangeTheme(ThemeEvents event, Emitter<ThemeState> emit) async {
    emit(ThemeState(theme: state.theme is LightTheme ? DarkTheme() : LightTheme()));
  }
}
