import 'dart:convert';

class IssueQR {

    final String type = "issue";
    final String? sessionId;
    final Map<String, dynamic>? invitation;

    const IssueQR({ this.sessionId, this.invitation });

    String toJson() => jsonEncode({
        'type': type,
        'sessionId': sessionId,
        'invitation': invitation,
    });
}

class ProofQR {

    final String type = "proof";
    final String? alias;
    final String? credRevId;
    final String? revRegId;

    const ProofQR({ this.alias, this.credRevId, this.revRegId});
    
    String toJson() => jsonEncode({
        'type': type,
        'alias': alias,
        'credRevId': credRevId,
        'revRegId': revRegId
    });
}