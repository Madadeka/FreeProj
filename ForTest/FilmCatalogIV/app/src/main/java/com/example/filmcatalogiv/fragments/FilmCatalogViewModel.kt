package com.example.filmcatalogiv.fragments

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.filmcatalogiv.model.DataKeeper
import com.example.filmcatalogiv.model.FilmsListener
import com.example.filmcatalogiv.model.SimpleFilm

class FilmCatalogViewModel(private val dataKeeper : DataKeeper) : ViewModel () {

    private val _films = MutableLiveData<List<SimpleFilm>>()
    val films: LiveData<List<SimpleFilm>> = _films

    // состояние фрагмента: загрузка, ошибка, ошибка поиска
//    private var _state = MutableLiveData<Int>()
//    var state: LiveData<Int> = _state
//    // доступ к бд
//    private val likeRepository = LikeRepository.get()

    private val listener: FilmsListener = {
        _films.value = it
//        if (it.count() != 0){ _state.value = 2 }
    }

    init {
//        _state.value = 1
        loadFilms()
    }

    fun loadFilms(){
        dataKeeper.addListener(listener)
    }

    override fun onCleared() {
        super.onCleared()
        dataKeeper.removeListener(listener)
    }

    fun onSearch(str: String){
        dataKeeper.searchQuery(str, 1)
    }


}