package com.example.filmcatalogiv.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.filmcatalogiv.databinding.FragmentFilmCatalogBinding
import com.example.filmcatalogiv.model.SimpleFilm

class FilmCatalogFragment : Fragment(), ViewBehavior {

    private lateinit var binding: FragmentFilmCatalogBinding
    private lateinit var adapter: FilmListAdapter


    private val viewModel: FilmCatalogViewModel by viewModels { factory() }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentFilmCatalogBinding.inflate(layoutInflater)

        binding.searchView.setOnQueryTextListener(object: SearchView.OnQueryTextListener{
            //изменение текста в SearchView
            override fun onQueryTextChange(newText: String?): Boolean {
                //Log.e("onQueryTextChange", "called");

                return false
            }
            //нажат ввод на клавиатуре SearchView
            override fun onQueryTextSubmit(query: String): Boolean {
                //посылаю поисковый запрос, и обрабатываю его
                if (query != ""){
                    viewModel.onSearch(query)
                }
                return false
            }
        })

        adapter = FilmListAdapter(object : FilmActionListener{
            override fun endOfList() {
                //TODO загрузить следующую порцию фильмов
                Toast.makeText(activity,"пролистал до конца",Toast.LENGTH_LONG).show()
            }

            override fun onFilmDetails(film: SimpleFilm) {
                Toast.makeText(activity,film.name,Toast.LENGTH_SHORT).show()
            }

        })

        viewModel.films.observe(viewLifecycleOwner, { adapter.films = it })

        val layoutManager = LinearLayoutManager(requireContext())
        binding.filmListView.layoutManager = layoutManager
        binding.filmListView.adapter = adapter

        return binding.root
    }

    override fun onError() {
        TODO("Not yet implemented")
    }

    override fun onSearchEmpty() {
        TODO("Not yet implemented")
    }

    override fun onListShow() {
//        binding.filmListView.visibility = RecyclerView.VISIBLE
//        binding.fragmentStateProgressBar.visibility = ProgressBar.GONE
    }

    override fun onLoad() {
//        binding.filmListView.visibility = RecyclerView.GONE
//        binding.fragmentStateProgressBar.visibility = ProgressBar.VISIBLE
    }

}



