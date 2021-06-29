package com.example.ivmoviereviews

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class Result {
    @SerializedName("display_title")
    @Expose
    var displayTitle: String? = null

    @SerializedName("mpaa_rating")
    @Expose
    var mpaaRating: String? = null

    @SerializedName("critics_pick")
    @Expose
    var criticsPick: Int? = null

    @SerializedName("byline")
    @Expose
    var byline: String? = null

    @SerializedName("headline")
    @Expose
    var headline: String? = null

    @SerializedName("summary_short")
    @Expose
    var summaryShort: String? = null

    @SerializedName("publication_date")
    @Expose
    var publicationDate: String? = null

    @SerializedName("opening_date")
    @Expose
    var openingDate: String? = null

    @SerializedName("date_updated")
    @Expose
    var dateUpdated: String? = null

    @SerializedName("link")
    @Expose
    var link: Link? = null

    @SerializedName("multimedia")
    @Expose
    var multimedia: Multimedia? = null

}