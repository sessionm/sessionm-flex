package sessionm.flex.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.sessionm.api.AchievementData;
import com.sessionm.api.SessionM;
import com.sessionm.api.User;
import sessionm.flex.SessionMExtension;
import sessionm.flex.util.SessionMDataUtil;
import org.json.JSONException;
import org.json.JSONObject;

public class GetUnclaimedAchievementFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("GetUnclaimedAchievementFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        AchievementData unclaimedAchievement = sessionM.getUnclaimedAchievement();
        FREObject freObject = null;

        if(unclaimedAchievement != null) {
            JSONObject json;
            try {
                json = SessionMDataUtil.achievementToJSON(unclaimedAchievement);
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
