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

public class GetUserFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("GetUserFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        User user = sessionM.getUser();
        FREObject freObject = null;

        if(user != null) {
            JSONObject json;
            try {
                json = SessionMDataUtil.userToJSON(user);
            }
            catch (JSONException e) {
                json = null;
            }

            if(json != null) {
                try {
                    freObject =  FREObject.newObject(json.toString());
                }
                catch (FREWrongThreadException e) {
                    freObject = null;
                }
            }
        }
        return freObject;
    }

}
