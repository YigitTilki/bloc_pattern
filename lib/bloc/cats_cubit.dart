import 'package:bloc_pattern/bloc/cats_repository.dart';
import 'package:bloc_pattern/bloc/cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsRepository _catsRepository;
  CatsCubit(this._catsRepository) : super(const CatsInitial());

  Future<void> getCats() async {
    try {
      emit(
        const CatsLoading(),
      );
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      final response = await _catsRepository.getCats();
      emit(CatsCompleted(response));
    } on NetworkError catch (e) {
      emit(
        CatsError(e.message),
      );
    }
  }
}
