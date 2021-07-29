package com.example.filmcatalogiv

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.filmcatalogiv.databinding.ActivityMainBinding
import com.example.filmcatalogiv.fragments.FilmCatalogFragment

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)


        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .add(R.id.fragmentContainer, FilmCatalogFragment())
                .commit()
        }
    }
}