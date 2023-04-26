package com.example.int_flutter

import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.platform.PlatformView
import android.content.Context
import android.content.Intent
import android.widget.Button
import android.widget.LinearLayout
import android.widget.EditText
import android.view.View
import kotlin.random.Random

internal class AndroidButtonView(context: Context, viewId: Int,  creationParams: Map<String?, Any?>?, binaryMessenger: BinaryMessenger): PlatformView {

    private val button: Button = Button(context)
    private val intentName = "EVENTS"
    private val intentMessageId = "CALL"
    private val layout: LinearLayout = LinearLayout(context)
    private val editText: EditText = EditText(context)

    override fun getView(): View {
        return layout
    }

    override fun dispose() { }
    
    init{
        layout.orientation = LinearLayout.VERTICAL
        layout.addView(editText)
        layout.addView(button)

        editText.hint = "Enter the text"
        editText.textSize = 13f

        button.textSize = 13f
        button.text = "Android Native Button"
        button.setOnClickListener{
            val intent = Intent(intentName)
            intent.putExtra(intentMessageId, editText.text.toString())
            context.sendBroadcast(intent)
        }
    }
}