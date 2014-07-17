package ludia.sessionm;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/* Extension entry point. This is referenced in the platform.xml file.
*/
public class SessionMExtension implements FREExtension {

    public static String TAG = SessionMExtension.class.getSimpleName();
    public static FREContext context;

    @Override
    public void initialize()
    {
        log("initialize");
    }

    @Override
    public FREContext createContext(java.lang.String string)
    {
        log("createContext");
        context = new SessionMExtensionContext();
        return context;
    }

    @Override
    public void dispose()
    {
        log("dispose");
        context = null;
    }

    public static void log(String s)
    {
        Log.d(TAG, s);
        if(context != null)
        {
            context.dispatchStatusEventAsync("LOG", s);
        }
    }

    public static void logError(String s)
    {
        Log.e(TAG, s);
        if(context != null)
        {
            context.dispatchStatusEventAsync("LOG", s);
        }
    }
}
