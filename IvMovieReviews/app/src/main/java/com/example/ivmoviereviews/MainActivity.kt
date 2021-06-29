package com.example.ivmoviereviews

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class MainActivity : AppCompatActivity(), Callback<MovieSearchResult> {

    private lateinit var retrofit: Retrofit
    private lateinit var service: NytimesService
    private lateinit var movieView: RecyclerView

    private var loading = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        movieView = findViewById(R.id.movieView)

        movieView.layoutManager = LinearLayoutManager(this)

        retrofit = Retrofit.Builder().
                    baseUrl("https://api.nytimes.com").
                    addConverterFactory(GsonConverterFactory.create()).
                    build()

        service = retrofit.create(NytimesService::class.java)

        startQuery()
    }

    // Загружаю список фильмов
    fun startQuery() {

        loading = true;

        val call = service.search("RS0s5bTyaYDXb1hggMxYVGBbmCzrOuyd")

        call.enqueue(this)
    }

override fun onFailure(call: Call<MovieSearchResult>, t: Throwable) {
    loading = false
    val text = "Что-то пошло не так"
    val toast = Toast.makeText(applicationContext, text, Toast.LENGTH_LONG)
    toast.show()
}

override fun onResponse(call: Call<MovieSearchResult>, response: Response<MovieSearchResult>) {
    val movieSearch: MovieSearchResult? = response.body()
    if(movieSearch?.status == "OK"){
        var movie = movieSearch.results!!
        //Для каждого фильма должно быть название, описание, картинка.
        //"display_title" "summary_short" "multimedia":"src"
        //для удобства выберу только те данные, которые нужны
        var movieList = mutableListOf<SimpleObj>()
        for (m in movie){
            val simpleObj = SimpleObj(
                    m.displayTitle!!,
                    m.summaryShort!!,
                    m.multimedia!!.src!!
            )
            movieList.add(simpleObj)
        }
        movieView.adapter = CustomRecyclerAdapter(movieList)
    }
    loading = false
}

}