package com.example.int_flutter


import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.BroadcastReceiver
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import kotlin.random.Random
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.Job

import java.util.logging.StreamHandler
import com.example.int_flutter.AndroidButtonViewFactrory



class MainActivity: FlutterActivity() {
    private val androidViewId = "INTEGRATION_ANDROID"
    private val eventsChannel  = "CALL_EVENTS" //идентификаторы
    private val methodChannelId  = "CALL_METHOD"
    private val intentName  = "EVENTS"
    private val intentMessageId  = "CALL"
   

    private var receiver: BroadcastReceiver? = null
    

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){ //метод конфигурит движок флаттера
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry.registerViewFactory(androidViewId, AndroidButtonViewFactrory(flutterEngine.dartExecutor.binaryMessenger))

       

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelId).setMethodCallHandler{
            call, result -> 
            if(call.method == intentMessageId){
                
            }
            else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
            object: EventChannel.StreamHandler{
                override fun onListen(args: Any?, events: EventChannel.EventSink){
                    receiver = createReceiver(events)
                    applicationContext?.registerReceiver(receiver, IntentFilter(intentName))
                    

                }
                override fun onCancel(args: Any?){
            
                    receiver = null
                }
            }

           
        )
    }

    fun createReceiver(events: EventChannel.EventSink):BroadcastReceiver?{
        return object : BroadcastReceiver(){
            override fun onReceive(context: Context, intent: Intent){
                 events.success(intent.getStringExtra(intentMessageId) ?: "")
            }
        }
    }

    fun generateRandomString(length: Int): String {
        val charPool : List<Char> = ('a'..'z') + ('A'..'Z') + ('0'..'9')
        return (1..length)
            .map { Random.nextInt(0, charPool.size) }
            .map(charPool::get)
            .joinToString("")
    }
}
