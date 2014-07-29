package sessionm.flex.functions;

import android.app.Activity;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sessionm.api.AchievementData;
import com.sessionm.api.SessionM;
import sessionm.flex.CustomAchievementActivity;
import sessionm.flex.SessionMExtension;

public class InitCustomActivityFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("InitCustomActivityFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        AchievementData unclaimedAchievement = sessionM.getUnclaimedAchievement();

        if (unclaimedAchievement != null) {
            Activity activity = freContext.getActivity();
            CustomAchievementActivity customAchievement = new CustomAchievementActivity(activity, unclaimedAchievement);
            
            customAchievement.present();
        }
        
        return null;
    }
}
