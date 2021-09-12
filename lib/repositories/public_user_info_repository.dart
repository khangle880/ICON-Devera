import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icon/models/public_user_info.dart';

import 'base_firestore_repository.dart';

class PublicInfoRepository extends FirestoreRepository<PublicInfo> {
  PublicInfoRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : super(
          firebaseFirestore: firebaseFirestore,
          collectionRef: (firebaseFirestore ?? FirebaseFirestore.instance)
              .collection('public_info'),
        );

  @override
  Stream<List<PublicInfo>> getAllDoc(String uid) {
    return firebaseFirestore
        .collection('public_info')
        .where("status", isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return PublicInfo.fromJson(data);
            }).toList());
  }
}
