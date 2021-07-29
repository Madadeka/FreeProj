package com.example.filmcatalogiv


import com.example.filmcatalogiv.model.SearchResult
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

//api_key=6ccd72a2a8fc239b13f209408fc31c33&
//language=ru&
//sort_by=popularity.desc&
//include_adult=false&
//include_video=false&
//page=1&
//with_watch_monetization_types=flatrate

interface DataService {

    @GET("/3/discover/movie")
    fun getStart(@Query("api_key") apiKey: String): Call<SearchResult>

    @GET("/3/discover/movie")
    fun getAll(@Query("api_key") apiKey: String,
               @Query("language") language: String,
               @Query("sort_by") sort_by: String,
               @Query("include_adult") include_adult: String,
               @Query("include_video") include_video: String,
               @Query("page") page: String,
               @Query("with_watch_monetization_types") with_watch_monetization_types: String
                ): Call<SearchResult>

//    https://api.themoviedb.org/3/search/movie?
//    api_key=6ccd72a2a8fc239b13f209408fc31c33&
//    language=ru&
//    query=<text>&			<- тут текст запроса
//    page=1&					<- тут страница выдачи
//    include_adult=false

    @GET("/3/search/movie")
    fun search(@Query("api_key") apiKey: String,
               @Query("language") language: String,
               @Query("query") query: String,
               @Query("page") page: String,
               @Query("include_adult") include_adult: String): Call<SearchResult>
}