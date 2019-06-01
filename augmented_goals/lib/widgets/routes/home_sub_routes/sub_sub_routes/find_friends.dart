import 'package:augmented_goals/blocs/find_friends.dart';
import 'package:augmented_goals/data_classes/account.dart';
import 'package:augmented_goals/widgets/list_tiles/text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FindFriends extends StatefulWidget {
  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  FindFriendsBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = FindFriendsBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.state,
      initialData: NoInput(),
      builder: (BuildContext context, AsyncSnapshot<SearchState> snapshot) {
        if (snapshot.data == null) return Text("Error");
        final state = snapshot.data;

        Widget input = TextField(
          decoration: InputDecoration(hintText: "Search for friends"),
          onChanged: bloc.onSearchChange.add,
        );

        Widget buildBody = Stack(
          children: <Widget>[
            SearchStateMessage(
              visible: state is NoInput,
              message: "Type a friends full name",
            ),
            SearchLoading(visible: state is Loading),
            SearchResult(
              visible: state is Result,
              accounts: state is Result ? state.accounts : [],
              bloc: bloc,
            ),
            SearchStateMessage(
              visible: state is Empty,
              message: "No accounts have this query as their full name.",
            ),
            SearchStateMessage(
              visible: state is Error,
              message: "The application encountered an error.",
            ),
          ],
        );

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: input,
            ),
            body: buildBody);
      },
    );
  }
}

class AccountTile extends StatefulWidget {
  final Account account;
  final FindFriendsBloc bloc;

  const AccountTile({Key key, this.account, this.bloc}) : super(key: key);

  @override
  AccountTileState createState() {
    return new AccountTileState(false);
  }
}

class AccountTileState extends State<AccountTile> {
  bool requestSent;

  AccountTileState(this.requestSent);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          widget.account.accountPictureUrl,
          width: 50.0,
          height: 50.0,
        ),
        title: Text(widget.account.name),
        trailing: Card(
          shape: CircleBorder(
              side: BorderSide(style: BorderStyle.solid, color: Colors.black)),
          child: GestureDetector(
            onTap: () async {
              if (!requestSent) {
                bool result =
                    await widget.bloc.sendFriendRequest(widget.account);
                if (result) {
                  setState(() {
                    requestSent = true;
                  });
                }
              }
            },
            child: CircleAvatar(
                backgroundColor: Colors.lightBlueAccent,
                child: Icon(
                  // TODO make icon adjust to if already friends, and ensure the pending state is persistent after a search change
                  requestSent ? Icons.hourglass_full : Icons.person_add,
                  color: Colors.black,
                )),
          ),
        ),
        /*onTap: ()=> Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewAccount(account)));*/
      ),
    );
  }
}

class SearchLoading extends StatelessWidget {
  final bool visible;

  const SearchLoading({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible is Loading,
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(value: 0.0),
          Text("Loading...")
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final bool visible;
  final List<Account> accounts;
  final FindFriendsBloc bloc;

  const SearchResult({Key key, this.visible, this.accounts, this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: ListView(
          children: accounts
              .map((account) => AccountTile(
                    account: account,
                    bloc: bloc,
                  ))
              .toList()),
    );
  }
}

class SearchStateMessage extends StatelessWidget {
  final bool visible;
  final String message;

  const SearchStateMessage({Key key, this.visible, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(visible: visible, child: TextTile(message: message));
  }
}
