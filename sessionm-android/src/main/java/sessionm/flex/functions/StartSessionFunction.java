package sessionm.flex.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sessionm.api.SessionM;
import sessionm.flex.SessionMExtension;

public class StartSessionFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {

        SessionMExtension.log("LogActionFunction.call()");

        String appID = readAliasFromArgument(freObjects);

        SessionMExtension.log("Using appID: " + appID);

        SessionM sessionM = SessionM.getInstance();
        sessionM.setAutopresentMode(false);
        sessionM.startSession(freContext.getActivity().getApplicationContext(), appID);

        return null;
    }

    private String readAliasFromArgument(FREObject[] freObjects)
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
