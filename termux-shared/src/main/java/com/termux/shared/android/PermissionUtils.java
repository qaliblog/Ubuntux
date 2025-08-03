package com.termux.shared.android;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import androidx.appcompat.app.AppCompatActivity;

public class PermissionUtils {
    
    public static boolean checkPermission(Context context, String permission) {
        // Placeholder implementation
        return true;
    }
    
    public static boolean checkPermissions(Context context, String[] permissions) {
        // Placeholder implementation
        return true;
    }
    
    public static void requestPermission(AppCompatActivity activity, String permission, int requestCode) {
        // Placeholder implementation
    }
    
    public static void requestPermission(Activity activity, String permission, int requestCode) {
        // Placeholder implementation
    }
    
    public static boolean validateDisplayOverOtherAppsPermissionForPostAndroid10(Context context, boolean showToast) {
        // Placeholder implementation
        return true;
    }
}