package com.example.ivmoviereviews

import retrofit2.Call;
import retrofit2.http.GET
import retrofit2.http.Query

interface NytimesService {
    @GET("/svc/movies/v2/reviews/all.json")
    fun search(@Query("api-key") apiKey: String): Call<MovieSearchResult>
}