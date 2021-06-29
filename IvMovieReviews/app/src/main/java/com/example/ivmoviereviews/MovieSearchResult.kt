package com.example.ivmoviereviews

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class MovieSearchResult {
    @SerializedName("status")
    @Expose
    var status: String? = null

    @SerializedName("copyright")
    @Expose
    var copyright: String? = null

    @SerializedName("has_more")
    @Expose
    var hasMore: Boolean? = null

    @SerializedName("num_results")
    @Expose
    var numResults: Int? = null

    @SerializedName("results")
    @Expose
    var results: List<Result>? = null

}