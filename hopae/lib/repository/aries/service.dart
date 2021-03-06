import 'package:hopae/repository/aries/model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'service.g.dart';

@RestApi(baseUrl: "http://192.168.137.1")
abstract class AriesService {

    factory AriesService({ String? baseUrl }) {
        final dio = Dio();
        
        return _AriesService(dio);
    }

    @POST(":{port}/connections/create-invitation")
    @Headers({ "Content-Type": "application/json;charset=utf-8" })
    Future<String> requestCreateInvitation(
        @Body() String body,
        @Path("port") int port,
        @Query("alias") String alias,
        @Query("auto_accept") bool autoAccept
    );
    
    @GET(":{port}/credentials")
    Future<String> requestCredentials(
        @Path("port") int port
    );

    @DELETE(":{port}/credential/{cred_id}")
    Future<HttpResponse> requestDelCredentials(
        @Path("port") int port,
        @Path("cred_id") String credId,
    );
    
    @GET(":{port}/wallet/did")
    Future<Wallet> requestWallet(
        @Path("port") int port
    );
    
    @GET(":{port}/connections")
    Future<String> requestConnections(
        @Path("port") int port,
        @Query("alias") String alias,
        @Query("state") String state
    );
}