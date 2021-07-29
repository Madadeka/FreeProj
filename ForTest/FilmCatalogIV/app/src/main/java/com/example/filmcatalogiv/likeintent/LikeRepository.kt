package com.example.filmcatalogiv.likeintent
//
//import android.arch.persistence.room.Room
//import android.content.Context
//import com.example.filmcatalogiv.database.LikeDataBase
//import com.example.filmcatalogiv.model.Like
//import kotlinx.coroutines.CoroutineScope
//import kotlinx.coroutines.Dispatchers
//import kotlinx.coroutines.launch
//
//private const val DATABASE_NAME = "like"
//
//class LikeRepository private constructor(context: Context) {
//        private val database: LikeDataBase = Room.databaseBuilder(
//            context.applicationContext,
//            LikeDataBase::class.java,
//            DATABASE_NAME
//        ).build()
//        private val likeDAO = database.likeDAO()
//
//        fun getLike(id: Long): Like  {
//            var tempLike = Like()
//            CoroutineScope(Dispatchers.Default).launch {
//                tempLike = likeDAO.getLike(id)
//            }
//            return tempLike
//        }
//
//        fun insert(like: Like) {
//            CoroutineScope(Dispatchers.Default).launch {
//                likeDAO.insert(like)
//            }
//        }
//
//        fun update(like: Like) {
//            CoroutineScope(Dispatchers.Default).launch {
//                likeDAO.update(like)
//            }
//        }
//
//        fun delete(like: Like) {
//            CoroutineScope(Dispatchers.Default).launch {
//                likeDAO.delete(like)
//            }
//        }
//
//        companion object {
//            private var INSTANCE: LikeRepository? = null
//            fun initialize(context: Context) {
//                if (INSTANCE == null) {
//                    INSTANCE = LikeRepository(context)
//                }
//            }
//
//            fun get(): LikeRepository {
//                return INSTANCE ?: throw IllegalStateException("LikeRepository must be initialized")
//            }
//        }
//}