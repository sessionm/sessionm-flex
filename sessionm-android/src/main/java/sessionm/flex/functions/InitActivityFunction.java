package sessionm.flex.functions;

import android.app.Activity;
import android.content.Intent;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import sessionm.flex.InitActivityActivity;
import sessionm.flex.SessionMExtension;

public class InitActivityFunction implements FREFunction {

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {

        SessionMExtension.log("InitActivityFunction.call()");

        String type = readActivityType(freObjects);

        Activity activity = freContext.getActivity();
        Intent intent = new Intent(activity.getApplicationContext(), InitActivityActivity.class);
        intent.putExtra("ACT_TYPE", type);

        try {
            activity.startActivity(intent);
        }
        catch (Exception e) {
            SessionMExtension.logError("Error: " + e.toString());
        }

        return null;
    }

    private String readActivityType(FREObject[] freObjects)
    {
        String action = null;

        try
        {
            action = freObjects[0].getAsString();
        }
        //Exception of type FREInvalidObjectException, FREWrongThreadException or  FRETypeMismatchException
        catch (Exception e)
        {
            SessionMExtension.logError("Couldn't retrieve action : " + e.getMessage());
        }
        finally
        {
            return action;
        }
    }
}
