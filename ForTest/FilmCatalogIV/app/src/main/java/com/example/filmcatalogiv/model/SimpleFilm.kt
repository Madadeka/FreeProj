package com.example.filmcatalogiv.model

data class SimpleFilm(val id: Int,
                      val name: String,
                      val overView: String,
                      val posterPath: String,
                      var like: Boolean,
                      val releaseDate: String,
                      val srcURL: String)