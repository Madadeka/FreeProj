package com.example.ivmoviereviews

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName


class Link {
    @SerializedName("type")
    @Expose
    var type: String? = null

    @SerializedName("url")
    @Expose
    var url: String? = null

    @SerializedName("suggested_link_text")
    @Expose
    var suggestedLinkText: String? = null

}