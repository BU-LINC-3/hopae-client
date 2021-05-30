package com.example.hopae

import android.telecom.Call
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.POST

interface LoginService {

    @FormUrlEncoded
    @POST("/subLogin/web/login.do")
    fun requestLogin(
        @Field("userId") userId:String,
        @Field("userPwd") userPwd:String
    ) : retrofit2.Call<Login>
}