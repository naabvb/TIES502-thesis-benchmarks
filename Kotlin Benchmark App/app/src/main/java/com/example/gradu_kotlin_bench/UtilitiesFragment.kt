package com.example.gradu_kotlin_bench

import android.annotation.SuppressLint
import android.os.Bundle
import android.os.StrictMode
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.fragment.app.Fragment
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import org.json.JSONObject
import java.io.BufferedReader
import java.io.InputStreamReader
import java.lang.System.nanoTime
import java.net.HttpURLConnection
import java.net.URL
import java.util.concurrent.TimeUnit
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import kotlin.system.measureTimeMillis


class UtilitiesFragment : Fragment() {
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private var start = 12345678910L
    private var done = 12345678910L

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(requireContext())
        return inflater.inflate(R.layout.utilities_fragment, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        view.findViewById<Button>(R.id.gpsButton).setOnClickListener {
            start = nanoTime()
            getLocation(view)
        }

        view.findViewById<Button>(R.id.cryptoButton).setOnClickListener {
            val cryptoExecTime = cryptoMark()
            view.findViewById<TextView>(R.id.cryptoResultText).text = "$cryptoExecTime ms"
        }

        view.findViewById<Button>(R.id.jsonButton).setOnClickListener {
            val response = getJSON()
            val jsonExecTime = measureTimeMillis {
                JSONObject(response)
            }
            view.findViewById<TextView>(R.id.jsonResultText).text = "$jsonExecTime ms"

        }
    }

    private fun getJSON(): String {
        try {
            // Allow running get request on main thread. Doesn't impact test as we are only measuring JSON parse time.
            val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()
            StrictMode.setThreadPolicy(policy)
            val url =
                URL("https://raw.githubusercontent.com/naabvb/TIES502-thesis-benchmarks/master/Assets/10mb-sample.json")
            val con = url.openConnection() as HttpURLConnection
            val responseCode = con.responseCode
            return if (responseCode == HttpURLConnection.HTTP_OK) { // 200
                val `in` =
                    BufferedReader(InputStreamReader(con.inputStream))
                var inputLine: String?
                val response = StringBuffer()
                while (`in`.readLine().also { inputLine = it } != null) {
                    response.append(inputLine)
                }
                `in`.close()
                response.toString()
            } else {
                ""
            }
        } catch (e: Exception) {
            println("Error $e")
        }

        return ""
    }

    @SuppressLint("MissingPermission") // Permissions checked on MainActivity
    private fun getLocation(view: View) {
        fusedLocationClient.lastLocation.addOnSuccessListener { location ->
            if (location != null) {
                done = nanoTime()
                var execTime = TimeUnit.NANOSECONDS.toMillis((done - start))
                view.findViewById<TextView>(R.id.gpsResultText2).text =
                    "${location.latitude} - ${location.longitude}"
                view.findViewById<TextView>(R.id.gpsResultText1).text =
                    "Accuracy: ${location.accuracy}"
                view.findViewById<TextView>(R.id.gpsResultText).text = "$execTime ms"
            }
        }
    }

    private fun cryptoMark(): String {
        val executionTime = measureTimeMillis {
            for (i in 1 until 800000) {
                createHMAC(i);
            }
        }
        return executionTime.toString();
    }

    private fun createHMAC(i: Number): ByteArray? {
        val key = "test-key"
        val data = "verysecretteststring$i"
        val sha256Hmac = Mac.getInstance("HmacSHA256")
        val secretKey = SecretKeySpec(key.toByteArray(), "HmacSHA256")
        sha256Hmac.init(secretKey)
        return sha256Hmac.doFinal(data.toByteArray())


    }
}