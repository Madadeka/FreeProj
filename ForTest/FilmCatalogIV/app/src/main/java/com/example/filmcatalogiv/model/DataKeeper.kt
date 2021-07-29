package com.example.filmcatalogiv.model

import com.example.filmcatalogiv.DataService
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

typealias FilmsListener = (films: List<SimpleFilm>) -> Unit

class DataKeeper : Callback<SearchResult> {

    private var films = mutableListOf<SimpleFilm>()
    private val listeners = mutableSetOf<FilmsListener>()

    private var service: DataService
    private var retrofit: Retrofit

    private var isLoaded = false

    init {
        retrofit = Retrofit.Builder().
        baseUrl("https://api.themoviedb.org").
        addConverterFactory(GsonConverterFactory.create()).
        build()
        service = retrofit.create(DataService::class.java)
//        firstLoad()
        startQuery(1)
    }

     //Загружаю список фильмов
    fun startQuery(page: Int) {
        val call: Call<SearchResult> =
            service.getAll("6ccd72a2a8fc239b13f209408fc31c33",
                "ru",
                "popularity.desc",
                "false",
                "false",
                "$page",
                "flatrate")
        call.enqueue(this)
    }

    private fun firstLoad(){
        val call: Call<SearchResult> =
            service.getStart("6ccd72a2a8fc239b13f209408fc31c33")
        call.enqueue(this)
    }

     //Поиск фильмов по названию
    fun searchQuery(query: String, page: Int){
         films.clear()
        val call: Call<SearchResult> =
            service.search("6ccd72a2a8fc239b13f209408fc31c33",
                "en",
                query,
                "$page",
                "false")
        call.enqueue(this)
    }

    override fun onResponse(call: Call<SearchResult>, response: Response<SearchResult>) {
        val filmSearch: SearchResult? = response.body()
        if(filmSearch != null){
            val resultSearch = filmSearch.results
            for (film in resultSearch){
                val simpleObj = SimpleFilm(
                    film.id,
                    film.title,
                    film.overview,
                    film.posterPath,
                    false,
                    film.releaseDate,
                    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + film.posterPath
                )
                films.add(simpleObj)
            }
            isLoaded = true
            notifyChanges()
        }
    }

    override fun onFailure(call: Call<SearchResult>, t: Throwable) {
        isLoaded = false
        throw IllegalStateException("Ошибка сервера")
    }

    fun addListener(listener: FilmsListener) {
        listeners.add(listener)
        if (isLoaded){
            listener.invoke(films)
        }
    }

    fun removeListener(listener: FilmsListener) {
        listeners.remove(listener)
    }

    private fun notifyChanges() {
        if (isLoaded){
            listeners.forEach { it.invoke(films) }
        }
    }

}