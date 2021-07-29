package com.example.filmcatalogiv.fragments

import android.view.LayoutInflater
import android.view.View
import android.view.View.OnClickListener
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.filmcatalogiv.R
import com.example.filmcatalogiv.databinding.RecyclerViewItemBinding
import com.example.filmcatalogiv.model.SimpleFilm
import com.squareup.picasso.Picasso

class FilmListAdapter(private val actionListener: FilmActionListener):
    RecyclerView.Adapter<FilmListAdapter.FilmViewHolder>(), OnClickListener{

    class FilmViewHolder(
        val binding: RecyclerViewItemBinding
    ): RecyclerView.ViewHolder(binding.root)

    var films: List<SimpleFilm> = emptyList()
        set(value) {
            field = value
            notifyDataSetChanged()
        }


    override fun getItemCount() = films.count()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FilmViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = RecyclerViewItemBinding.inflate(inflater, parent, false)

        binding.root.setOnClickListener(this)
        binding.likeImageView.setOnClickListener(this)

        return FilmViewHolder(binding)
    }

    override fun onBindViewHolder(holder: FilmViewHolder, position: Int) {
        val film = films[position]
        with(holder.binding){
            holder.itemView.tag = film
            likeImageView.tag = film
            textViewDisplayTitle.text = film.name
            textViewSummaryShort.text = film.overView
            releaseDateView.text = film.releaseDate

        if (film.like)
            likeImageView.setImageResource(R.drawable.ic_heart_fill)
        else
            likeImageView.setImageResource(R.drawable.ic_heart)

        Picasso.
        get().
        load(film.srcURL).
        resize(600,900).
        placeholder(R.drawable.ic_baseline_image_24).
        centerCrop().
        error(R.drawable.ic_baseline_image_not_supported_24).
        into(imageViewScr)
        }
        if (position == films.count() - 1){
            actionListener.endOfList()
        }
    }

    override fun onClick(p0: View) {
        val film = p0.tag as SimpleFilm
        when(p0.id){
            R.id.likeImageView -> {
                //TODO
                // записать в базу like = true,
                // поменять картинку на likeImageView.setImageResource(R.drawable.ic_heart_fill)
                film.like = !film.like
                notifyDataSetChanged()
            }
            else -> {
                actionListener.onFilmDetails(film)
            }
        }
    }


}