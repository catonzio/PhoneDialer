package com.example.phone_dialer

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.content.Intent
//import com.google.gms.actions.NoteIntents

class MainActivity : FlutterActivity() {
    private var savedNote: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        val intent = intent
        val action = intent.action
        val type = intent.type

        /*if (NoteIntents.ACTION_CREATE_NOTE == action && type != null) {
            if ("text/plain" == type) {
                handleSendText(intent)
            }
        }

        MethodChannel(flutterView, "app.channel.shared.data").setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "getSavedNote") {
                result.success(savedNote)
                savedNote = null
            }
        }*/
    }

    private fun handleSendText(intent: Intent) {
        savedNote = intent.getStringExtra(Intent.EXTRA_TEXT)
    }
}