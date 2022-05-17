import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uId ;
  DatabaseService(this.uId);

  //List of brews from Snapshots
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return  snapshot.docs.map((doc){
      return Brew(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 100,
        sugar: doc.get('sugar') ?? ''
      );
    }).toList();
  }

  //UserModel from document snapshot
  UserModel _userModelFromSnapshot(DocumentSnapshot snapshot){
    return UserModel(uId: uId,
        name: snapshot.get('name'),
        sugar: snapshot.get('sugar'),
        strength: snapshot.get('strength')
    );
  }

  Stream<UserModel> get userData{
    return brewCollection.doc(uId).snapshots()
        .map((_userModelFromSnapshot));
  }

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Stream <List<Brew>> get brews{
    return brewCollection.snapshots()
    .map((_brewListFromSnapshot));
  }

  Future updateUserData (String name,String sugar, int strength) async {

    return await brewCollection.doc(uId).set({
      'name': name,
      'sugar': sugar,
      'strength': strength
    });
  }
}