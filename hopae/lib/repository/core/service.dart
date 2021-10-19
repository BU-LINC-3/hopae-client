import 'package:hopae/repository/core/model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'service.g.dart';

@RestApi(baseUrl: "http://192.168.0.11")
abstract class CoreService {

    factory CoreService({ String? baseUrl }) {
        final dio = Dio();
        
        return _CoreService(dio);
    }

    @GET("/api/did/issuer/create-session")
    Future<HttpResponse<SessionInfo>> requestSession(
        @Query("univerGu") int univerGu,
        @Query("userId") String userId,
        @Query("userPw") String userPw
    );
    
}