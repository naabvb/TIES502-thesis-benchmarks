package com.example.gradu_kotlin_bench

import android.animation.Animator
import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.LinearInterpolator
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.navArgs

/**
 * Animations page fragment
 */
class AnimationsFragment : Fragment() {

    var spinning = false
    private var animations: MutableList<Animator> = ArrayList()
    private val animatorSet = AnimatorSet()
    private val args: AnimationsFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        var layoutType: Int
        layoutType = R.layout.animations_fragment_low
        if (args.columns == 16) layoutType = R.layout.animations_fragment_high
        if (args.columns == 8) layoutType = R.layout.animations_fragment_medium
        return inflater.inflate(layoutType, container, false)
    }

    private fun createAnim(index: Int, view: View) {
        view.setLayerType(View.LAYER_TYPE_HARDWARE, null)
        var imageViewObjectAnimator = ObjectAnimator.ofFloat(
            view,
            "rotation", 360f, 0f
        )
        if (index % 2 == 0) {
            imageViewObjectAnimator = ObjectAnimator.ofFloat(
                view,
                "rotation", 0f, 360f
            )
        }
        imageViewObjectAnimator.duration = 500
        imageViewObjectAnimator.repeatCount = ObjectAnimator.INFINITE
        imageViewObjectAnimator.repeatMode = ObjectAnimator.RESTART
        imageViewObjectAnimator.interpolator = LinearInterpolator()
        animations.add(imageViewObjectAnimator)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        view.findViewById<Button>(R.id.animation_startButton).setOnClickListener {
            var images = getViewsByTag(view as ViewGroup, "testikuva")
            if (!spinning) {
                if (images != null) {
                    for ((index, value) in images.withIndex()) {
                        createAnim(index, value)
                    }
                    animatorSet.playTogether(animations)
                    animatorSet.start()
                    spinning = true
                    view.findViewById<Button>(R.id.animation_startButton).text = "Stop"
                }
            } else {
                if (images != null) {
                    animatorSet.removeAllListeners()
                    animatorSet.end()
                    animatorSet.cancel()
                }
                spinning = false
                view.findViewById<Button>(R.id.animation_startButton).text = "Start"
            }
        }
    }

    private fun getViewsByTag(root: ViewGroup, tag: String): ArrayList<View>? {
        val views = ArrayList<View>()
        val childCount = root.childCount
        for (i in 0 until childCount) {
            val child = root.getChildAt(i)
            if (child is ViewGroup) {
                views.addAll(getViewsByTag(child, tag)!!)
            }
            val tagObj = child.tag
            if (tagObj != null && tagObj == tag) {
                views.add(child)
            }
        }
        return views
    }

    override fun onResume() {
        super.onResume()
        (activity as AppCompatActivity?)!!.supportActionBar!!.hide()
    }

    override fun onStop() {
        super.onStop()
        (activity as AppCompatActivity?)!!.supportActionBar!!.show()
    }
}