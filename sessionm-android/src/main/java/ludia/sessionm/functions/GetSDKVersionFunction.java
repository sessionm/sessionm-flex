package ludia.sessionm.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.sessionm.api.SessionM;
import com.sessionm.api.User;
import ludia.sessionm.SessionMExtension;
import ludia.sessionm.util.SessionMDataUtil;
import org.json.JSONException;
import org.json.JSONObject;

public class GetSDKVersionFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("GetSDKVersionFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        FREObject freObject;
        try {
            freObject =  FREObject.newObject(sessionM.getSDKVersion());
        }
        catch (FREWrongThreadException e) {
            freObject = null;
        }
        return freObject;
    }

}
