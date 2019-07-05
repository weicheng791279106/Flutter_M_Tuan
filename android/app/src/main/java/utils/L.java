package utils;

import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;

import java.net.UnknownHostException;

/**
 * log
 * Created by weicheng on 2016/12/8.
 */
public class L {

    private static boolean isPrintLog = false;
    /**每行log最大输出长度*/
    private static final int MAXLENGTH = 3999;
    /**默认log输出tag*/
    private static final String DEFAULT_TAG_I = "see";
    /**error级别默认输出tag*/
    private static final String DEFAULT_TAG_E = "error";

    /**设置是否输出日志*/
    public static void setIsPrintLog(boolean printLog){
        isPrintLog = printLog;
    }

    /**当前是否输出日志*/
    public static boolean isPrintLog(){
        return isPrintLog;
    }

    public static void e(String msg){
        L.e(DEFAULT_TAG_E,msg + "");
    }

    public static void e(String tag, String msg){
        if(isPrintLog()) Log.e(tag, msg + "");
    }

    /** 以级别为 e 的形式输出LOG信息和Throwable */
    public static void e(String tag, String msg, Throwable tr) {
        if (isPrintLog() && null != tr) {
            Log.e(tag, (isEmpty(msg) ? DEFAULT_TAG_E:msg)
                    + (tr instanceof UnknownHostException ? "\n" + tr.getMessage():"") /*系统Log类自动排除UnknownHostException的输出*/
                    , tr);
        }
    }

    public static void e(String tag, Throwable tr){
        e(tag,"",tr);
    }

    public static void e(Throwable tr){
        e(DEFAULT_TAG_E,"",tr);
    }

    public static void i(String msg){
        L.i(DEFAULT_TAG_I,msg + "");
    }

    /**防止log太长，控制台打印不全*/
    public static void i(String tag, String msg){
        if (msg == null) return;
        if (isPrintLog()){
            if (msg.length() > MAXLENGTH) {
                int chunkCount = msg.length() / MAXLENGTH;
                for (int i = 0; i <= chunkCount; i++) {
                    int max = MAXLENGTH * (i + 1);
                    if (max >= msg.length()) {
                        Log.i(tag, msg.substring(MAXLENGTH * i));
                    } else {
                        Log.i(tag, msg.substring(MAXLENGTH * i, max));
                    }
                }
            } else {
                Log.i(tag, msg);
            }
        }
    }

    /**输出JSON样式的Log*/
    public static void printJson(String tag, String title, String json) {
        String message;
        try {
            if (json.startsWith("{")) {
                message = new JSONObject(json).toString(4); /*4是缩进字符数*/
            } else if (json.startsWith("[")) {
                JSONArray jsonArray = new JSONArray(json);
                message = jsonArray.toString(4); /*4是缩进字符数*/
            } else {
                message = json;
            }
        } catch (Exception e) {
            message = json;
        }
        message = title + "\n" + message;
        L.i(tag,message);
    }

    public static boolean isEmpty(String content) {
        return content == null || content.trim().equals("") || content.trim().equals("null");
    }

}
