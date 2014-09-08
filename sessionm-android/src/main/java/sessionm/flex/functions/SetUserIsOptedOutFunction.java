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
        SessionM sessionM = SessionM.getInstance();

        //if (sessionM.getUser().isOptedOut()){
        //   SessionMExtension.log("SetUserIsOptedOutFunction: User optedout = true");
        //} else {
        //   SessionMExtension.log("SetUserIsOptedOutFunction: User optedout = false");
        //}

        boolean optedOut = readOptedOutStatusFromArgument(freObjects);
        sessionM.getUser().setOptedOut(freContext.getActivity().getApplicationContext(), optedOut);


        //if (sessionM.getUser().isOptedOut()){
        //   SessionMExtension.log("SetUserIsOptedOutFunction: User optedout after = true");
        //} else {
        //   SessionMExtension.log("SetUserIsOptedOutFunction: User optedout after = false");
        //}

        return null;
    }

    private boolean readOptedOutStatusFromArgument(FREObject[] freObjects)
    {
        boolean optedOut = false;

        try
        {
            optedOut = freObjects[0].getAsBool();
        }
        //Exception of type FREInvalidObjectException, FREWrongThreadException or  FRETypeMismatchException
        catch (Exception e)
        {
            SessionMExtension.logError("Couldn't retrieve new opted-out status : " + e.getMessage());
        }

        //if (optedOut) {
	//    SessionMExtension.log("SetUserIsOptedOutFunction new state: true");
        //} else {
	//    SessionMExtension.log("SetUserIsOptedOutFunction new state: false");
        //}



        return optedOut;
    }

}
