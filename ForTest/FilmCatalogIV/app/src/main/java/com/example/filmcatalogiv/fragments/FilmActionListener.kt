package com.example.filmcatalogiv.fragments

import com.example.filmcatalogiv.model.SimpleFilm

interface FilmActionListener {

    fun endOfList()

    fun onFilmDetails(film: SimpleFilm)

}