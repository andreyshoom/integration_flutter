package com.example.int_flutter

import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.platform.PlatformView
import android.content.Context
import com.example.int_flutter.AndroidButtonView


class AndroidButtonViewFactrory(messenger: BinaryMessenger): PlatformViewFactory(StandardMessageCodec.INSTANCE){

    private val binaryMessenger: BinaryMessenger = messenger

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return AndroidButtonView(context!!, viewId, creationParams, binaryMessenger)
     }
    
}

