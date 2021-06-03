package com.example.hopae

import android.telecom.Call
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST

interface LoginService {

    @FormUrlEncoded
    @POST("/subLogin/web/login.do?univerGu=1")
    fun requestLogin(
        // 인풋 정의
        @Field("userId") userId:String,
        @Field("userPwd") userPwd:String
    ) : retrofit2.Call<Login> // 아웃풋 정의
}
