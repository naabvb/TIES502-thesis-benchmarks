package com.example.gradu_kotlin_bench

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController


class AnimationsSelectionFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.animations_selection_fragment, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        view.findViewById<Button>(R.id.lowButton).setOnClickListener {
            val action =
                AnimationsSelectionFragmentDirections.actionAnimationsSelectionFragmentToSecondFragment(
                    4
                )
            findNavController().navigate(action)
        }

        view.findViewById<Button>(R.id.medButton).setOnClickListener {
            val action =
                AnimationsSelectionFragmentDirections.actionAnimationsSelectionFragmentToSecondFragment(
                    8
                )
            findNavController().navigate(action)
        }

        view.findViewById<Button>(R.id.highButton).setOnClickListener {
            val action =
                AnimationsSelectionFragmentDirections.actionAnimationsSelectionFragmentToSecondFragment(
                    16
                )
            findNavController().navigate(action)
        }
    }

}