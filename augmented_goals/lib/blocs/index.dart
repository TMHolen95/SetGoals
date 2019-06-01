import 'dart:async';

class IndexState{
    int index = 0;
    IndexState();
}

class IndexBloc{

  StreamController<IndexState> indexStateController = StreamController<IndexState>();
  Sink get updateIndexState => indexStateController.sink;
  Stream<IndexState> get stream => indexStateController.stream;

  IndexBloc();

  IndexState initial(){
    return IndexState();
  }

  void dispose(){
    indexStateController.close();
  }

  void _update(IndexState state){
    updateIndexState.add(state);
  }

  void updateIndex(IndexState state, int index){
    state.index = index;
    _update(state);
  }

}