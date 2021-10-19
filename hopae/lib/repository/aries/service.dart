import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'service.g.dart';

@RestApi(baseUrl: "https://www.bu.ac.kr")
abstract class AriesService {

    factory AriesService({ String? baseUrl }) {
        final dio = Dio();
        
        return _AriesService(dio);
    }

    @POST("/subLogin/web/login.do")
    Future<HttpResponse> requestLogin(
        @Query("univerGu") int univerGu,
        @Query("userId") String userId,
        @Query("userPwd") String userPw
    );
    
}