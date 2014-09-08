package sessionm.flex.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.sessionm.api.SessionM;
import com.sessionm.api.User;
import sessionm.flex.SessionMExtension;
import sessionm.flex.util.SessionMDataUtil;
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

        //if (user.isOptedOut()){
        //   SessionMExtension.log("GetUserFunction: User optedout = true");
        //} else {
        //   SessionMExtension.log("GetUserFunction: User optedout = false");
        //}
        //SessionMExtension.log("GetUserFunction - json: " + json.toString());


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
