import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<S> extends Cubit<S> {
  BaseBloc(S state) : super(state);


}
