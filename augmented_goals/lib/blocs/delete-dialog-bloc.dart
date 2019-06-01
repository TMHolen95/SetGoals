import 'dart:async';

class DeleteDialogState{
    bool deleted = false;
    String reference;
    DeleteDialogState();
}

class DeleteDialogBloc{


  StreamController<DeleteDialogState> deleteDialogStateController = StreamController<DeleteDialogState>();
  Sink get updateDeleteDialogState => deleteDialogStateController.sink;
  Stream<DeleteDialogState> get deleteDialogState => deleteDialogStateController.stream;

  DeleteDialogBloc();

  DeleteDialogState initial(){
    return DeleteDialogState();
  }

  void dispose(){
    deleteDialogStateController.close();
  }

  void _update(DeleteDialogState state){
    updateDeleteDialogState.add(state);
  }

  delete() {
    // TODO implement delete;
  }

}