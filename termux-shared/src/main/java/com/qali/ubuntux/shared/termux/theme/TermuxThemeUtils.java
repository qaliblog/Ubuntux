package com.qali.ubuntux.shared.termux.theme;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.qali.ubuntux.shared.termux.settings.properties.TermuxPropertyConstants;
import com.qali.ubuntux.shared.termux.settings.properties.TermuxSharedProperties;
import com.qali.ubuntux.shared.theme.NightMode;

public class TermuxThemeUtils {

    /** Get the {@link TermuxPropertyConstants#KEY_NIGHT_MODE} value from the properties file on disk
     * and set it to app wide night mode value. */
    public static void setAppNightMode(@NonNull Context context) {
        NightMode.setAppNightMode(TermuxSharedProperties.getNightMode(context));
    }

    /** Set name as app wide night mode value. */
    public static void setAppNightMode(@Nullable String name) {
        NightMode.setAppNightMode(name);
    }

}
