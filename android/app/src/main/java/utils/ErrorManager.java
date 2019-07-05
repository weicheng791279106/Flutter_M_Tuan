package utils;

import android.os.Build;
import android.os.Environment;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * UncaughtException处理类,当程序发生Uncaught异常的时候,由该类来接管程序,并记录发送错误报告.
 * 出现崩溃后的日志会分成两份存放在两个地方：
 *   第一个地方是CRASH_SAVE_PATH地址下，用于开发人员查找错误使用，
 *   第二个地方在sharedPreference中，用于等待上传服务器。
 * @author chenyen
 */
public class ErrorManager implements Thread.UncaughtExceptionHandler {

    /**单例*/
    private static volatile ErrorManager instance = null;
    private static final String TAG = "CrashManager";
    /**设备信息*/
    private Map<String, String> deviceInfo;

    public static ErrorManager get(){
        ErrorManager tempInst = instance;
        if (tempInst == null) {
            synchronized (ErrorManager.class) {
                tempInst = instance;
                if (tempInst == null) {
                    tempInst = new ErrorManager();
                    instance = tempInst;
                }
            }
        }
        return tempInst;
    }

    private ErrorManager() {
        /*覆盖默认的uncaughtExceptionHandler*/
        Thread.setDefaultUncaughtExceptionHandler(this);
    }

    @Override
    public void uncaughtException(Thread thread, Throwable ex) {
        handleException(ex);
    }

    /**
     * 自定义错误处理，收集错误信息，发送错误报告等操作均在此完成
     * @param ex
     */
    private void handleException(Throwable ex) {
        if (ex == null) return;
        L.e("crash",ex);
        /*收集设备参数信息*/
        Map<String,String> deviceInfo = collectDeviceInfo();
        String crashInfo = getExceptionInfo(ex,deviceInfo);
        /*保存日志文件*/
        saveCrashInfo2File(crashInfo);
        System.exit(1);
        return ;
    }

    /**收集设备参数信息 */
    public Map<String, String> collectDeviceInfo() {
        if(deviceInfo != null){
            return deviceInfo;
        }
        Map<String, String> result = new HashMap<>();
        try {
            result.put("android SDK", Build.VERSION.SDK_INT+""); /*系统版本号*/
        } catch (Exception e) {
            L.e(TAG, "an error occured when collect package info", e);
        }
        Field[] fields = Build.class.getDeclaredFields();
        for (Field field : fields) {
            try {
                field.setAccessible(true);
                result.put(field.getName(), field.get(null).toString());
            } catch (Exception e) {
                L.e(TAG, "an error occured when collect crash info", e);
            }
        }
        deviceInfo = result;
        return result;
    }

    /**拼装输出的异常信息*/
    public String getExceptionInfo( Throwable ex, Map<String,String> deviceInfo){
        if(ex == null )  return "";
        StringBuffer sb = new StringBuffer();
        if(deviceInfo != null){
            for (Map.Entry<String, String> entry : deviceInfo.entrySet()) {
                String key = entry.getKey();
                String value = entry.getValue();
                sb.append(key + "=" + value + "\n");
            }
        }
        Writer writer = new StringWriter();
        PrintWriter printWriter = new PrintWriter(writer);
        ex.printStackTrace(printWriter);
        Throwable cause = ex.getCause();
        while (cause != null) {
            cause.printStackTrace(printWriter);
            cause = cause.getCause();
        }
        printWriter.close();
        String result = writer.toString();
        sb.append(result);
        return sb.toString();
    }

    public static final String BASE_CACHE_DIR
            = Environment.getExternalStorageDirectory().getPath() + File.separator + "MTuan/Crash/";

    /**
     * 保存错误信息到文件中
     * @param crashInfo 需要保存的错误信息
     */
    private void saveCrashInfo2File(String crashInfo) {
        try {
            String filePath =  new SimpleDateFormat("yyyy-MM-dd", Locale.CHINA).format(new Date(System.currentTimeMillis())) + "/";
            String fileName = "crash-" + new SimpleDateFormat("HH:mm:ss", Locale.CHINA).format(new Date(System.currentTimeMillis())) + ".txt";
            writeFileData(filePath,fileName,crashInfo,false);
            return;
        } catch (Exception e) {
            L.e(TAG, "an error occured while writing file...", e);
        }
        return;
    }

    public static void writeFileData(String filePath, String fileName, String message, boolean append) {
        FileOutputStream fout = null;
        try {
            File dir = new File(filePath);
            if (!dir.exists()) dir.mkdirs();
            fout = new FileOutputStream(new File(filePath + "/" + fileName), append);
            byte[] bytes = message.getBytes();
            fout.write(bytes);
        } catch (Exception e) {
            L.e(e);
        } finally {
            if (fout != null) {
                try {
                    fout.close();
                } catch (IOException e) {
                    L.e(e);
                }
            }
        }
    }

}
