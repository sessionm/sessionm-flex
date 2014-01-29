package ludia.sessionm.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.sessionm.api.SessionM;
import ludia.sessionm.SessionMExtension;

public class GetSessionStateFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("GetSessionStateFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        String state = sessionM.getSessionState().toString();

        try {
            return FREObject.newObject(state);
        }
        catch (FREWrongThreadException e) {
            return null;
        }
    }

}
