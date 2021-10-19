import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'service.g.dart';

@RestApi(baseUrl: "https://www.bu.ac.kr")
abstract class BUAuthService {

    factory BUAuthService({ String? baseUrl }) {
        final dio = Dio();
        
        return _BUAuthService(dio);
    }

    @POST("/subLogin/web/login.do")
    @FormUrlEncoded()
    Future<HttpResponse> requestLogin(
        @Field("univerGu") int univerGu,
        @Field("userId") String userId,
        @Field("userPwd") String userPw
    );

    @GET("/restful/checkLogined.do")
    Future<String> requestLoginInfo(
        @Header("Cookie") String sessionId
    );
    
}