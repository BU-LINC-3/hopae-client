import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {

    Future<bool> clear() async {
        return (await SharedPreferences.getInstance()).clear();
    }

    Future<String> getUserId() {
        return Future<String>(() async {
            String? string = (await SharedPreferences.getInstance()).getString("userId");
            if (string == null) {
                return "";
            }

            return string;
        });
    }

    Future<bool> setUserId(String userId) async {
        return (await SharedPreferences.getInstance()).setString("userId", userId);
    }

    Future<bool> removeUserId() async {
        return (await SharedPreferences.getInstance()).remove("userId");
    }

    Future<String> getUserPw() {
        return Future<String>(() async {
            String? string = (await SharedPreferences.getInstance()).getString("userPw");
            if (string == null) {
                return "";
            }

            return string;
        });
    }

    Future<bool> setUserPw(String userPw) async {
        return (await SharedPreferences.getInstance()).setString("userPw", userPw);
    }

    Future<bool> removeUserPw() async {
        return (await SharedPreferences.getInstance()).remove("userPw");
    }

    Future<int> getPort() {
        return Future<int>(() async {
            int? port = (await SharedPreferences.getInstance()).getInt("port");
            if (port == null) {
                return -1;
            }

            return port;
        });
    }

    Future<bool> setPort(int port) async {
        return (await SharedPreferences.getInstance()).setInt("port", port);
    }

    Future<bool> removePort() async {
        return (await SharedPreferences.getInstance()).remove("port");
    }

    Future<String> getAlias() {
        return Future<String>(() async {
            String? string = (await SharedPreferences.getInstance()).getString("alias");
            if (string == null) {
                return "";
            }

            return string;
        });
    }

    Future<bool> setAlias(String string) async {
        return (await SharedPreferences.getInstance()).setString("alias", string);
    }

    Future<bool> removeAlias() async {
        return (await SharedPreferences.getInstance()).remove("alias");
    }


}