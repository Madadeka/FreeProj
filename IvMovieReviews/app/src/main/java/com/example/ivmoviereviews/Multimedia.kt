package com.example.ivmoviereviews

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class Multimedia {
    @SerializedName("type")
    @Expose
    var type: String? = null

    @SerializedName("src")
    @Expose
    var src: String? = null

    @SerializedName("height")
    @Expose
    var height: Int? = null

    @SerializedName("width")
    @Expose
    var width: Int? = null

}