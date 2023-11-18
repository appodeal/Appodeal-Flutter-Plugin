package com.appodeal.appodeal_flutter.native_ad

import android.content.Context
import android.graphics.Typeface
import android.text.TextUtils
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.annotation.Keep
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.ads.nativead.NativeAdViewAppWall
import com.appodeal.ads.nativead.NativeAdViewContentStream
import com.appodeal.ads.nativead.NativeAdViewNewsFeed
import com.appodeal.ads.nativead.NativeIconView
import com.appodeal.ads.nativead.NativeMediaView

@Keep
fun interface NativeAdViewBinder {
    fun bind(): NativeAdView
}

internal class TemplateNativeAdViewBinder(
    private val context: Context,
    private val nativeAdOptions: NativeAdOptions,
) : NativeAdViewBinder {
    override fun bind(): NativeAdView {
        val nativeAdView = when (val nativeAdViewType = nativeAdOptions.nativeAdViewType) {
            NativeAdViewType.ContentStream -> NativeAdViewContentStream(context)
            NativeAdViewType.AppWall -> NativeAdViewAppWall(context)
            NativeAdViewType.NewsFeed -> NativeAdViewNewsFeed(context)
            else -> throw IllegalArgumentException("Unknown NativeAdViewType: $nativeAdViewType")
        }

        val adChoicePosition = nativeAdOptions.adChoiceConfig.position
        nativeAdView.setAdChoicesPosition(adChoicePosition)

        val adAttributionBackgroundColor = nativeAdOptions.adAttributionConfig.backgroundColor
        nativeAdView.setAdAttributionBackground(adAttributionBackgroundColor)
        val adAttributionTextColor = nativeAdOptions.adAttributionConfig.textColor
        nativeAdView.setAdAttributionTextColor(adAttributionTextColor)

        val adTitleConfigFontSize = nativeAdOptions.adTitleConfig.fontSize.toFloat()
        (nativeAdView.titleView as? TextView)?.textSize = adTitleConfigFontSize

        val adDescriptionFontSize = nativeAdOptions.adDescriptionConfig.fontSize.toFloat()
        (nativeAdView.descriptionView as? TextView)?.textSize = adDescriptionFontSize

        val adActionButtonFontSize = nativeAdOptions.adActionButtonConfig.fontSize.toFloat()
        (nativeAdView.callToActionView as? Button)?.textSize = adActionButtonFontSize

        // TODO: 17/11/2023 [glavatskikh] think about icon size in template
//        val adIconConfigWidth = nativeAdOptions.adIconConfig.width
//        val adIconConfigHeight = nativeAdOptions.adIconConfig.height
//        (nativeAdView.iconView)?.layoutParams =
//            RelativeLayout.LayoutParams(adIconConfigWidth, adIconConfigHeight)

        return nativeAdView
    }
}

internal class DefaultNativeAdViewBinder(
    private val context: Context,
    private val nativeAdOptions: NativeAdOptions,
) : NativeAdViewBinder {
    override fun bind(): NativeAdView {
        // Create the NativeAdView
        val nativeAdView = NativeAdView(context)
        nativeAdView.id = View.generateViewId()
        nativeAdView.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )

        // Create the inner layout (ConstraintLayout)
        val constraintLayout = ConstraintLayout(context)
        constraintLayout.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )

        // Add NativeMediaView
        val mediaView = NativeMediaView(context)
        mediaView.id = View.generateViewId()
        constraintLayout.addView(mediaView)

        // Add NativeIconView
        val iconView = NativeIconView(context)
        iconView.id = View.generateViewId()
        constraintLayout.addView(iconView)

        // Add TextView for title
        val titleTextView = TextView(context)
        titleTextView.id = View.generateViewId()
        titleTextView.ellipsize = TextUtils.TruncateAt.END
        titleTextView.typeface = Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL)
        titleTextView.maxLines = 1
        titleTextView.isSingleLine = true
        titleTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)

        constraintLayout.addView(titleTextView)

        // Add TextView for description
        val descriptionTextView = TextView(context)
        descriptionTextView.id = View.generateViewId()
        descriptionTextView.ellipsize = TextUtils.TruncateAt.MARQUEE
        descriptionTextView.marqueeRepeatLimit = -1 // Equivalent to "marquee_forever"
        descriptionTextView.isSingleLine = true
        descriptionTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)
        constraintLayout.addView(descriptionTextView)

        // Add Button for CTA
        val ctaButton = Button(context)
        ctaButton.id = View.generateViewId()
        ctaButton.typeface = Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL)
        ctaButton.maxLines = 1
        ctaButton.isSingleLine = true
        ctaButton.setTextAppearance(context, android.R.style.TextAppearance_Small)
        constraintLayout.addView(ctaButton)

        // Add TextView for ad attribution
        val adAttributionTextView = TextView(context)
        adAttributionTextView.id = View.generateViewId()
        adAttributionTextView.layoutParams = ConstraintLayout.LayoutParams(
            ConstraintLayout.LayoutParams.WRAP_CONTENT,
            ConstraintLayout.LayoutParams.WRAP_CONTENT
        )
//        adAttributionTextView.gravity = Gravity.CENTER
//        adAttributionTextView.setBackgroundResource(R.color.red)
//        adAttributionTextView.elevation = context.resources.getDimension(R.dimen.base_elevation)
        adAttributionTextView.typeface = Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL)
        adAttributionTextView.maxLines = 1
        adAttributionTextView.isSingleLine = true
        adAttributionTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)
//        adAttributionTextView.setTextColor(ContextCompat.getColor(this, R.color.black))
        adAttributionTextView.text = "Ad"
        constraintLayout.addView(adAttributionTextView)

        // Set constraints using ConstraintSet
        val set = ConstraintSet()
        set.clone(constraintLayout)

        // Set constraints for NativeMediaView
        set.connect(
            mediaView.id, ConstraintSet.TOP,
            constraintLayout.id, ConstraintSet.TOP
        )
        set.connect(
            mediaView.id, ConstraintSet.START,
            constraintLayout.id, ConstraintSet.START
        )
        set.connect(
            mediaView.id, ConstraintSet.END,
            constraintLayout.id, ConstraintSet.END
        )
        set.constrainWidth(
            descriptionTextView.id,
            ConstraintSet.MATCH_CONSTRAINT
        ) // Match the width
        set.constrainHeight(descriptionTextView.id, ConstraintSet.WRAP_CONTENT) // Wrap the height

        // Set constraints for NativeIconView
        set.connect(
            iconView.id, ConstraintSet.TOP,
            mediaView.id, ConstraintSet.BOTTOM
        )
        set.connect(
            iconView.id, ConstraintSet.START,
            constraintLayout.id, ConstraintSet.START
        )
        set.connect(
            iconView.id, ConstraintSet.BOTTOM,
            constraintLayout.id, ConstraintSet.BOTTOM
        )
        set.setDimensionRatio(iconView.id, "H,1:1")
        set.constrainWidth(
            descriptionTextView.id,
            ConstraintSet.MATCH_CONSTRAINT
        ) // Match the width
        set.constrainHeight(
            descriptionTextView.id,
            ConstraintSet.MATCH_CONSTRAINT
        ) // Match the height

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
        set.connect(
            titleTextView.id, ConstraintSet.BOTTOM,
            descriptionTextView.id, ConstraintSet.TOP
        )
        set.constrainWidth(titleTextView.id, ConstraintSet.MATCH_CONSTRAINT) // Match the width
        set.constrainHeight(titleTextView.id, ConstraintSet.WRAP_CONTENT) // Wrap the height

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
        set.connect(
            descriptionTextView.id, ConstraintSet.BOTTOM,
            constraintLayout.id, ConstraintSet.BOTTOM
        )
        set.constrainWidth(
            descriptionTextView.id,
            ConstraintSet.MATCH_CONSTRAINT
        ) // Match the width
        set.constrainHeight(descriptionTextView.id, ConstraintSet.WRAP_CONTENT) // Wrap the height

        // Set constraints for ctaButton
        set.connect(
            ctaButton.id, ConstraintSet.TOP,
            mediaView.id, ConstraintSet.BOTTOM
        )
        set.connect(
            ctaButton.id, ConstraintSet.START,
            descriptionTextView.id, ConstraintSet.END,
        )
        set.connect(
            ctaButton.id, ConstraintSet.END,
            constraintLayout.id, ConstraintSet.END
        )
        set.connect(
            ctaButton.id, ConstraintSet.BOTTOM,
            constraintLayout.id, ConstraintSet.BOTTOM
        )
        set.constrainWidth(descriptionTextView.id, ConstraintSet.WRAP_CONTENT) // Wrap the width
        set.constrainHeight(descriptionTextView.id, ConstraintSet.WRAP_CONTENT) // Wrap the height

        // Set constraints for adAttributionTextView
        set.connect(
            adAttributionTextView.id, ConstraintSet.START,
            constraintLayout.id, ConstraintSet.START
        )
        set.connect(
            adAttributionTextView.id, ConstraintSet.TOP,
            constraintLayout.id, ConstraintSet.TOP
        )

        set.applyTo(constraintLayout)

        // Finally, return NativeAdView
        nativeAdView.titleView = titleTextView
        nativeAdView.callToActionView = ctaButton
        nativeAdView.descriptionView = descriptionTextView
        nativeAdView.iconView = iconView
        nativeAdView.mediaView = mediaView
        nativeAdView.adAttributionView = adAttributionTextView
        nativeAdView.addView(constraintLayout)
        return nativeAdView
    }
}