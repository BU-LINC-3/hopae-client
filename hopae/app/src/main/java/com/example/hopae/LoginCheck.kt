package com.example.hopae

import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET

interface LoginCheck {

    @GET("/restful/checkLogined.do")
    fun checkLogin(
        @Field("userId") userId:String,
        @Field("userNm") userNm:String
    ) : retrofit2.Call<Login>
}