part of 'bottom_map_padding_cubit.dart';

@immutable
abstract class BottomMapPaddingState {
  final double bottomPadding;
  const BottomMapPaddingState({required this.bottomPadding});
}

class BottomMapPaddingInitial extends BottomMapPaddingState {
  const BottomMapPaddingInitial({required double bottomPadding}) : super(bottomPadding: bottomPadding);
}
