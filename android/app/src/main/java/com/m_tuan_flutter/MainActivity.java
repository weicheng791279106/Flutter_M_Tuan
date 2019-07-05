package com.m_tuan_flutter;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import utils.ErrorManager;
import utils.L;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    ErrorManager.get();
    L.setIsPrintLog(true);
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),"android_log").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        String tag = methodCall.argument("tag");
        String message =  methodCall.argument("msg");
        switch (methodCall.method){

          case "logI":
            L.i(tag,message);
            break;

          case "logE":
            L.e(tag,message);
            break;

          case "logJSON":
            L.printJson("http","",message);
            break;

        }
      }
    });
  }
}
