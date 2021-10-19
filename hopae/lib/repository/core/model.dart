class SessionInfo {
    
    final int? port;

    final String? alias;

    const SessionInfo({ this.port, this.alias });

    factory SessionInfo.fromJson(Map<String, dynamic> json) {
        return SessionInfo(
            port: json['port'],
            alias: json['alias']
        );
    }

}