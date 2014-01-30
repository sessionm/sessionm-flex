package ludia.sessionm.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.sessionm.api.Activity;
import com.sessionm.api.SessionM;
import ludia.sessionm.SessionMExtension;

public class GetCurrentActivityTypeFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("GetCurrentActivityTypeFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        Activity currentActivity = sessionM.getCurrentActivity();
        FREObject freObject = null;

        if(currentActivity != null) {
            try {
                freObject = FREObject.newObject(currentActivity.getActivityType().toString());
            } catch (FREWrongThreadException e) {
                freObject  = null;
            }
        }

        return freObject;
    }

}
