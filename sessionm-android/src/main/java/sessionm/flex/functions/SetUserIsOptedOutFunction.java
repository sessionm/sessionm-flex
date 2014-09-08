package sessionm.flex.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sessionm.api.SessionM;
import sessionm.flex.SessionMExtension;

public class SetUserIsOptedOutFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("SetUserIsOptedOutFunction.call()");
        boolean optedOut = readOptedOutStatusFromArgument(freObjects);
        SessionM sessionM = SessionM.getInstance();
        sessionM.getUser().setOptedOut(freContext.getActivity().getApplicationContext(), optedOut);
        return null;
    }

    private boolean readOptedOutStatusFromArgument(FREObject[] freObjects)
    {
        Boolean optedOut = null;

        try
        {
            optedOut = freObjects[0].getAsBool();
        }
        //Exception of type FREInvalidObjectException, FREWrongThreadException or  FRETypeMismatchException
        catch (Exception e)
        {
            SessionMExtension.logError("Couldn't retrieve new opted-out status : " + e.getMessage());
        }

        boolean optedOutB = false;
        if (optedOut) {
            optedOutB = optedOut.booleanValue();
        }

        return optedOutB;
    }

}
