package com.example.filmcatalogiv

import android.app.Application
//import com.example.filmcatalogiv.likeintent.LikeRepository
import com.example.filmcatalogiv.model.DataKeeper

class App : Application() {

    val dataKeeper = DataKeeper()

//    override fun onCreate() {
//        super.onCreate()
//        LikeRepository.initialize(this)
//    }

}