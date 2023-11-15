package com.appodeal.appodeal_flutter.native_ad

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Typeface
import android.text.TextUtils
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.ads.nativead.NativeIconView
import com.appodeal.ads.nativead.NativeMediaView

@SuppressLint("ViewConstructor")
internal class NativeAdCustomView(
    private val context: Context,
    private val params: NativeAdCustomOptions?
) {
    @SuppressLint("InflateParams")
    fun bind(): NativeAdView {
        // Create the NativeAdView
        val nativeAdView = NativeAdView(context)
        nativeAdView.id = View.generateViewId()
        nativeAdView.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )

        params ?: return nativeAdView

        // Create the inner layout (ConstraintLayout)
        val rootLayout = ConstraintLayout(context)
        rootLayout.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        nativeAdView.addView(rootLayout)

        // Add NativeMediaView
        val mediaView = NativeMediaView(context)
        mediaView.id = View.generateViewId()
        rootLayout.addView(mediaView)

        // Add NativeIconView
        val iconView = NativeIconView(context)
        iconView.id = View.generateViewId()
        rootLayout.addView(iconView)

        // Add TextView for title
        val titleTextView = TextView(context)
        titleTextView.id = View.generateViewId()
        titleTextView.ellipsize = TextUtils.TruncateAt.END
        titleTextView.typeface = Typeface.create("sans-serif-medium", Typeface.NORMAL)
        titleTextView.maxLines = 1
        titleTextView.isSingleLine = true
        titleTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)

        rootLayout.addView(titleTextView)

        // Add TextView for description
        val descriptionTextView = TextView(context)
        descriptionTextView.id = View.generateViewId()
        descriptionTextView.ellipsize = TextUtils.TruncateAt.MARQUEE
        descriptionTextView.marqueeRepeatLimit = -1 // Equivalent to "marquee_forever"
        descriptionTextView.isSingleLine = true
        descriptionTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)
        rootLayout.addView(descriptionTextView)

        // Add Button for CTA
        val ctaButton = Button(context)
        ctaButton.id = View.generateViewId()
        ctaButton.typeface = Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL)
        ctaButton.maxLines = 1
        ctaButton.isSingleLine = true
        ctaButton.setTextAppearance(context, android.R.style.TextAppearance_Small)
        rootLayout.addView(ctaButton)

        // Set constraints using ConstraintSet
        val set = ConstraintSet()
        set.clone(rootLayout)

        // Set constraints for NativeMediaView
        set.connect(
            mediaView.id, ConstraintSet.TOP,
            nativeAdView.id, ConstraintSet.TOP
        )
        set.connect(
            mediaView.id, ConstraintSet.START,
            rootLayout.id, ConstraintSet.START
        )
        set.connect(
            mediaView.id, ConstraintSet.END,
            rootLayout.id, ConstraintSet.END
        )

        // Set constraints for NativeIconView
        set.connect(
            iconView.id, ConstraintSet.TOP,
            mediaView.id, ConstraintSet.BOTTOM
        )
        set.connect(
            iconView.id, ConstraintSet.START,
            rootLayout.id, ConstraintSet.START
        )
        set.setDimensionRatio(iconView.id, "H,1:1")

        // Set constraints for titleTextView
        set.connect(
            titleTextView.id, ConstraintSet.TOP,
            mediaView.id, ConstraintSet.BOTTOM
        )
        set.connect(
            titleTextView.id, ConstraintSet.START,
            iconView.id, ConstraintSet.END
        )
        set.connect(
            titleTextView.id, ConstraintSet.END,
            ctaButton.id, ConstraintSet.START
        )

        // Set constraints for descriptionTextView
        set.connect(
            descriptionTextView.id, ConstraintSet.TOP,
            titleTextView.id, ConstraintSet.BOTTOM
        )
        set.connect(
            descriptionTextView.id, ConstraintSet.START,
            titleTextView.id, ConstraintSet.START
        )
        set.connect(
            descriptionTextView.id, ConstraintSet.END,
            titleTextView.id, ConstraintSet.END
        )

        // Set constraints for ctaButton
        set.connect(
            ctaButton.id, ConstraintSet.TOP,
            mediaView.id, ConstraintSet.BOTTOM
        )
        set.connect(
            ctaButton.id, ConstraintSet.END,
            rootLayout.id, ConstraintSet.END
        )

        set.applyTo(rootLayout)

        // Finally, return NativeAdView
        return nativeAdView
    }

}