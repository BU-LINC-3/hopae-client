class Wallet {
    
    final List<DID>? didList;

    const Wallet({ this.didList });

    factory Wallet.fromJson(Map<String, dynamic> json) {
        return Wallet(
            didList: (json['result'] as List).map((e) => DID.fromJson(e)).toList()
        );
    }

    DID get getLatestDID {
        return didList!.first;
    }
}

class DID {
    
    final String? did;
    final String? verkey;
    final String? posture;

    const DID({ this.did, this.verkey, this.posture });

    factory DID.fromJson(Map<String, dynamic> json) {
        return DID(
            did: json['did'],
            verkey: json['verkey'],
            posture: json['posture']
        );
    }
}