package com.appodeal.appodeal_flutter.native_ad

import android.content.Context
import android.content.res.Resources
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.text.TextUtils
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.FrameLayout
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

        // Create AdAttributionTextView
        val adAttributionTextView = TextView(context)
        adAttributionTextView.id = View.generateViewId()
        // set ad attribution config
        val adAttributionConfig = nativeAdOptions.adAttributionConfig
        adAttributionTextView.textSize = adAttributionConfig.fontSize.toFloat()
        adAttributionTextView.setTextColor(adAttributionConfig.textColor)
        adAttributionTextView.setBackgroundColor(adAttributionConfig.backgroundColor)
        // TODO: 18/11/2023 [glavatskikh] val margin: Int = 0,
        // set default ad attribution
        adAttributionTextView.text = "Ad"
        adAttributionTextView.maxLines = 1
        adAttributionTextView.elevation = 2f.dpToPx
        adAttributionTextView.isSingleLine = true
        adAttributionTextView.gravity = Gravity.CENTER
        adAttributionTextView.layoutParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT,
        ).apply { gravity = Gravity.START or Gravity.TOP }
        adAttributionTextView.typeface = Typeface.create("sans-serif-medium", Typeface.NORMAL)
        adAttributionTextView.maxLines = 1
        adAttributionTextView.isSingleLine = true
        adAttributionTextView.gravity = Gravity.CENTER
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            adAttributionTextView.setTextAppearance(android.R.style.TextAppearance_Small)
        } else {
            adAttributionTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)
        }

        // Create the inner layout (ConstraintLayout)
        val constraintLayout = ConstraintLayout(context)
        constraintLayout.id = View.generateViewId()
        // set ad layout config
        val adLayoutConfig = nativeAdOptions.adLayoutConfig
        constraintLayout.layoutParams = ConstraintLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        ).apply {
            val margin = adLayoutConfig.margin.dpToPx
            setMargins(margin, margin, margin, margin)
        }

        // Add NativeMediaView
        val mediaView = NativeMediaView(context)
        mediaView.id = View.generateViewId()
        // set ad media config
        val adMediaConfig = nativeAdOptions.adMediaConfig
        mediaView.visibility = if (adMediaConfig.visible) View.VISIBLE else View.GONE
        // TODO: 18/11/2023 [glavatskikh] val margin: Int = 0,
        constraintLayout.addView(mediaView)

        // Add NativeIconView
        val iconView = NativeIconView(context)
        iconView.id = View.generateViewId()
        // set ad icon config
        val adIconConfig = nativeAdOptions.adIconConfig
        iconView.visibility = if (adIconConfig.visible) View.VISIBLE else View.GONE
        val iconViewSize = adIconConfig.size.dpToPx
        iconView.layoutParams = ConstraintLayout.LayoutParams(iconViewSize, iconViewSize)
        // TODO: 18/11/2023 [glavatskikh] val margin: Int = 0,
        constraintLayout.addView(iconView)

        // Add TextView for title
        val titleTextView = TextView(context)
        titleTextView.id = View.generateViewId()
        // set ad title config
        val adTitleConfig = nativeAdOptions.adTitleConfig
        titleTextView.textSize = adTitleConfig.fontSize.toFloat()
        titleTextView.setTextColor(adTitleConfig.textColor)
        titleTextView.setBackgroundColor(adTitleConfig.backgroundColor)
        // TODO: 18/11/2023 [glavatskikh] val margin: Int = 0,
        // set default ad title
        titleTextView.ellipsize = TextUtils.TruncateAt.END
        titleTextView.maxLines = 1
        titleTextView.isSingleLine = true
        titleTextView.typeface = Typeface.create("sans-serif-medium", Typeface.NORMAL)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            titleTextView.setTextAppearance(android.R.style.TextAppearance_Small)
        } else {
            titleTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)
        }
        constraintLayout.addView(titleTextView)

        // Add TextView for description
        val descriptionTextView = TextView(context)
        descriptionTextView.id = View.generateViewId()
        // set ad description config
        val adDescriptionConfig = nativeAdOptions.adDescriptionConfig
        descriptionTextView.textSize = adDescriptionConfig.fontSize.toFloat()
        descriptionTextView.setTextColor(adDescriptionConfig.textColor)
        descriptionTextView.setBackgroundColor(adDescriptionConfig.backgroundColor)
        // TODO: 18/11/2023 [glavatskikh] val margin: Int = 0,
        // set default ad description
        descriptionTextView.ellipsize = TextUtils.TruncateAt.MARQUEE
        descriptionTextView.marqueeRepeatLimit = -1 // Equivalent to "marquee_forever"
        descriptionTextView.typeface = Typeface.create("sans-serif-medium", Typeface.NORMAL)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            descriptionTextView.setTextAppearance(android.R.style.TextAppearance_Small)
        } else {
            descriptionTextView.setTextAppearance(context, android.R.style.TextAppearance_Small)
        }
        constraintLayout.addView(descriptionTextView)

        // Add Button for CTA
        val ctaButton = Button(context)
        ctaButton.id = View.generateViewId()
        // set ad action button config
        val adActionButtonConfig = nativeAdOptions.adActionButtonConfig
        ctaButton.textSize = adActionButtonConfig.fontSize.toFloat()
        ctaButton.setTextColor(adActionButtonConfig.textColor)
        val ctaButtonBackground = GradientDrawable().apply {
            shape = GradientDrawable.RECTANGLE
            cornerRadius = adActionButtonConfig.radius.toFloat().dpToPx
            setColor(adActionButtonConfig.backgroundColor)
            setStroke(2, ctaButton.currentTextColor)
        }
        ctaButton.background = ctaButtonBackground
        // TODO: 18/11/2023 [glavatskikh] val margin: Int = 0,
        // set ad action button config
        ctaButton.maxLines = 1
        ctaButton.isSingleLine = true
        ctaButton.typeface = Typeface.create("sans-serif-medium", Typeface.NORMAL)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            ctaButton.setTextAppearance(android.R.style.TextAppearance_Small)
        } else {
            ctaButton.setTextAppearance(context, android.R.style.TextAppearance_Small)
        }
        constraintLayout.addView(ctaButton)

        // Set constraints using ConstraintSet
        val set = ConstraintSet()
        set.clone(constraintLayout)

        // Set constraints for mediaView
        set.connect(mediaView.id, ConstraintSet.TOP, constraintLayout.id, ConstraintSet.TOP)
        set.connect(mediaView.id, ConstraintSet.START, constraintLayout.id, ConstraintSet.START)
        set.connect(mediaView.id, ConstraintSet.END, constraintLayout.id, ConstraintSet.END)
        set.constrainWidth(mediaView.id, ConstraintSet.MATCH_CONSTRAINT)
        set.constrainHeight(mediaView.id, ConstraintSet.WRAP_CONTENT)

        // Set constraints for iconView
        val iconMarginTop = 8.dpToPx
        set.connect(iconView.id, ConstraintSet.TOP, mediaView.id, ConstraintSet.BOTTOM, iconMarginTop) // icon margin top
        set.connect(iconView.id, ConstraintSet.START, constraintLayout.id, ConstraintSet.START)
        set.connect(iconView.id, ConstraintSet.BOTTOM, constraintLayout.id, ConstraintSet.BOTTOM)
        set.setDimensionRatio(iconView.id, "H,1:1")
        set.constrainWidth(iconView.id, ConstraintSet.MATCH_CONSTRAINT)
        set.constrainHeight(iconView.id, ConstraintSet.MATCH_CONSTRAINT)

        // Set constraints for titleTextView
        val titleMargin = 8.dpToPx
        set.connect(titleTextView.id, ConstraintSet.TOP, mediaView.id, ConstraintSet.BOTTOM, titleMargin) // title margin top
        set.connect(titleTextView.id, ConstraintSet.START, iconView.id, ConstraintSet.END, titleMargin) // title margin start
        set.connect(titleTextView.id, ConstraintSet.END, ctaButton.id, ConstraintSet.START, titleMargin) // title margin end
        set.connect(titleTextView.id, ConstraintSet.BOTTOM, descriptionTextView.id, ConstraintSet.TOP)
        set.constrainWidth(titleTextView.id, ConstraintSet.MATCH_CONSTRAINT_SPREAD)
        set.constrainHeight(titleTextView.id, ConstraintSet.WRAP_CONTENT)

        // Set constraints for descriptionTextView
        set.connect(descriptionTextView.id, ConstraintSet.TOP, titleTextView.id, ConstraintSet.BOTTOM)
        set.connect(descriptionTextView.id, ConstraintSet.START, titleTextView.id, ConstraintSet.START)
        set.connect(descriptionTextView.id, ConstraintSet.END, titleTextView.id, ConstraintSet.END)
        val descriptionMarginBottom = 8.dpToPx
        set.connect(descriptionTextView.id, ConstraintSet.BOTTOM, constraintLayout.id, ConstraintSet.BOTTOM, descriptionMarginBottom) // description margin bottom
        set.constrainWidth(descriptionTextView.id, ConstraintSet.MATCH_CONSTRAINT_SPREAD)
        set.constrainHeight(descriptionTextView.id, ConstraintSet.WRAP_CONTENT)

        // Set constraints for ctaButton
        val ctaButtonMarginTop = 8.dpToPx
        set.connect(ctaButton.id, ConstraintSet.TOP, mediaView.id, ConstraintSet.BOTTOM, ctaButtonMarginTop) // cta button margin top
        set.connect(ctaButton.id, ConstraintSet.END, constraintLayout.id, ConstraintSet.END)
        set.connect(ctaButton.id, ConstraintSet.BOTTOM, constraintLayout.id, ConstraintSet.BOTTOM)
        val ctaButtonHorizontalPadding = 20.dpToPx
        ctaButton.setPadding(ctaButtonHorizontalPadding, ctaButton.paddingTop, ctaButtonHorizontalPadding, ctaButton.paddingBottom)
        set.constrainWidth(ctaButton.id, ConstraintSet.WRAP_CONTENT)
        set.constrainHeight(ctaButton.id, ConstraintSet.WRAP_CONTENT)

        // Apply constraints
        set.applyTo(constraintLayout)

        // Finally, return NativeAdView
        nativeAdView.titleView = titleTextView
        nativeAdView.callToActionView = ctaButton
        nativeAdView.descriptionView = descriptionTextView
        nativeAdView.iconView = iconView
        nativeAdView.mediaView = mediaView
        nativeAdView.adAttributionView = adAttributionTextView
        nativeAdView.addView(constraintLayout)
        nativeAdView.addView(adAttributionTextView)
        return nativeAdView
    }
}

private val Int.dpToPx: Int
    get() = TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        this.toFloat(),
        Resources.getSystem().displayMetrics
    ).toInt()

private val Float.dpToPx: Float
    get() = TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        this,
        Resources.getSystem().displayMetrics
    )