package com.example.filmcatalogiv.model

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class SearchResult {
    @SerializedName("page")
    @Expose
    var page: Int = 0

    @SerializedName("results")
    @Expose
    var results: List<Result> = emptyList()

    @SerializedName("total_pages")
    @Expose
    var totalPages: Int = 0

    @SerializedName("total_results")
    @Expose
    var totalResults: Int = 0
}