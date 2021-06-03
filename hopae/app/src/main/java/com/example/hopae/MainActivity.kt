package com.example.hopae

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AlertDialog
import kotlinx.android.synthetic.main.activity_main.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        var retrofit = Retrofit.Builder()
            .baseUrl("https://www.bu.ac.kr")
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        var loginService = retrofit.create(LoginService::class.java)
        var loginCheck = retrofit.create(LoginCheck::class.java)


        btn_login.setOnClickListener(){
            var textId = ed_id.text.toString()
            var textPw = ed_pw.text.toString()

            // loginServie.requestLogin(textId, textPw).enqueue(object : Callback<Login>
            loginService.requestLogin(textId, textPw).enqueue(object : Callback<Login>{
                override fun onFailure(call: Call<Login>, t: Throwable) {
                    // 통신 실패, t: Throwable
//                    Log.d("DEBUG", t.toString())
                    var dialog = AlertDialog.Builder(this@MainActivity)
                    dialog.setTitle("실패!")
                    dialog.setMessage("통신에 실패")
                    dialog.show()
                }

                override fun onResponse(call: Call<Login>, response: Response<Login>) {
                    // 통신 성공
                    var login = response.body()

                    var dialog = AlertDialog.Builder(this@MainActivity)
                    dialog.setTitle("성공!")
                    dialog.setMessage("userId = " + login?.userId + ", userNm = " + login?.userNm )
                }

            })

            var dialog = AlertDialog.Builder(this@MainActivity)
            dialog.setTitle("알람")
            dialog.setMessage("id: " + textId)
            dialog.show()
        }
    }
}
