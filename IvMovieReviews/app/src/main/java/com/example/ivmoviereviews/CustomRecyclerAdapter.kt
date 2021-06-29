package com.example.ivmoviereviews

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso

class CustomRecyclerAdapter(private val list: MutableList<SimpleObj>):
        RecyclerView.Adapter<CustomRecyclerAdapter.MyViewHolder>(){
        class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
            var displayTitleTextView: TextView? = null
            var summaryShortTextView: TextView? = null
            var scrImageView: ImageView? = null

            init {
                displayTitleTextView = itemView.findViewById(R.id.textViewDisplayTitle)
                summaryShortTextView = itemView.findViewById(R.id.textViewSummaryShort)
                scrImageView = itemView.findViewById(R.id.imageViewScr)
            }
        }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val itemView =
                LayoutInflater.from(parent.context)
                        .inflate(R.layout.recyclerview_item, parent, false)
        return MyViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.displayTitleTextView!!.text = list[position].title
        holder.summaryShortTextView!!.text = list[position].summary

        Picasso.
            get().
            load(list[position].srcURL).
            resize(380,200).
            centerCrop().
            placeholder(R.drawable.ic_launcher_background).
            error(R.drawable.ic_launcher_foreground).
            into(holder.scrImageView)
    }

    override fun getItemCount(): Int {
        return list.count()
    }


}