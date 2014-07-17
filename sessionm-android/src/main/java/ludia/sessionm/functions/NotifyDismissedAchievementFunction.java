package ludia.sessionm.functions;

import android.app.Activity;
import android.content.Intent;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sessionm.api.AchievementActivity.AchievementDismissType;
import com.sessionm.api.AchievementData;
import com.sessionm.api.SessionM;
import ludia.sessionm.CustomAchievementActivity;
import ludia.sessionm.SessionMExtension;

public class NotifyDismissedAchievementFunction implements FREFunction {
    
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        
        SessionMExtension.log("NotifyDismissedAchievementFunction.call()");
        SessionM sessionM = SessionM.getInstance();
        AchievementData unclaimedAchievement = sessionM.getUnclaimedAchievement();
        String type = readDismissType(freObjects);
        
        if (unclaimedAchievement != null && type != null) {
            Activity activity = freContext.getActivity();
            CustomAchievementActivity customAchievement = new CustomAchievementActivity(activity, unclaimedAchievement);
            
            if (type.equals(AchievementDismissType.CLAIMED)) {
                customAchievement.claim();
            }
            else if (type.equals(AchievementDismissType.CANCELLED)) {
                customAchievement.dismiss();
            }
            else {
                SessionMExtension.logError("Invalid dismiss type : " + type);
            }
        }
        
        return null;
    }
    
    private String readDismissType(FREObject[] freObjects)
    {
        String dismiss_type = null;
        
        try
        {
            dismiss_type = freObjects[0].getAsString();
        }
        //Exception of type FREInvalidObjectException, FREWrongThreadException or  FRETypeMismatchException
        catch (Exception e)
        {
            SessionMExtension.logError("Couldn't retrieve dismiss type : " + e.getMessage());
        }
        finally
        {
            return dismiss_type;
        }
    }
}
