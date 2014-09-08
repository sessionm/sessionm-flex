package sessionm.flex.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.sessionm.api.SessionM;
import sessionm.flex.SessionMExtension;
import sessionm.flex.util.SessionMDataUtil;
import org.json.JSONException;
import org.json.JSONObject;

public class IsActivityPresentedFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("IsActivityPresented.call()");
        SessionM sessionM = SessionM.getInstance();

        FREObject freObject = null;

        boolean presented = sessionM.isActivityPresented();

        try {
            freObject = FREObject.newObject(presented);
        } catch (FREWrongThreadException e) {
            SessionMExtension.logError("Unable to convert boolean to AS3 object");
        }

        return freObject;
    }

}
