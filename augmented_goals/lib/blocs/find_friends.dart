import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:rxdart/rxdart.dart';

abstract class SearchState{}
class NoInput extends SearchState{
  String info = "Search by friend's full name";
  NoInput();
}
class Loading extends SearchState{
  String loading = "Loading...";
  Loading();
}
class Result extends SearchState{
  List<Account> accounts;
  Result(List<Account> accounts){
    this.accounts = accounts;
  }
}
class Empty extends SearchState{
  Empty();
}

class Error extends SearchState{
  String error;
  Error(String error){
    this.error = error;
  }
}

class FindFriendsBloc{
  PublishSubject<String> onSearchChange;
  Stream<SearchState> state;

  FindFriendsBloc(){
    this.onSearchChange = PublishSubject<String>();
    this.state = onSearchChange.distinct()
        .debounce(const Duration(milliseconds: 250))
        .switchMap<SearchState>((String search) => mapEventToState(search))
        .startWith(NoInput());
  }

  void dispose(){
    onSearchChange.close();
  }

  static Stream<SearchState> mapEventToState(String search) async*{
    if(search.isEmpty){
      yield NoInput();
    } else {
      yield Loading();
    }

    try{
      List<Account> accounts = await FirestoreAPI.searchForAccounts(search);
      if(accounts.isEmpty){
        yield Empty();
      } else {
        yield Result(accounts);
      }

    } catch(e){
      yield Error(e.toString());
    }

  }

  Future<bool> sendFriendRequest(Account account) {
    return FirestoreAPI.sendFriendRequest(account);
  }
}