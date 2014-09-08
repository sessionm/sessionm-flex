package sessionm.flex;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.sessionm.api.AchievementData;
import com.sessionm.api.SessionListener;
import com.sessionm.api.SessionM;
import com.sessionm.api.User;
import sessionm.flex.functions.*;
import sessionm.flex.util.SessionMDataUtil;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class SessionMExtensionContext extends FREContext implements SessionListener {

    public static String SESSION_STATE_CHANGED = "SESSION_STATE_CHANGED";
    public static String SESSION_FAILED = "SESSION_FAILED";
    public static String USER_UPDATED = "USER_UPDATED";
    public static String UNCLAIMED_ACHIEVEMENT = "UNCLAIMED_ACHIEVEMENT";


    public SessionMExtensionContext()
    {
        super();
        SessionM.getInstance().setSessionListener(this);
    }

    @Override
    public Map<String, FREFunction> getFunctions()
    {
        SessionMExtension.log("Preparing functions");
        HashMap<String, FREFunction> map = new HashMap<String, FREFunction>();
        map.put("startSession", new StartSessionFunction());
        map.put("logAction", new LogActionFunction());
        map.put("logDebug", new LogDebugFunction());
        map.put("initActivity", new InitActivityFunction());
        map.put("initCustomActivity", new InitCustomActivityFunction());
        map.put("isActivityPresented", new IsActivityPresentedFunction());
        map.put("notifyDismissedAchievement", new NotifyDismissedAchievementFunction());
        map.put("getUser", new GetUserFunction());
        map.put("setUserIsOptedOut", new SetUserIsOptedOutFunction());
        map.put("getUnclaimedAchievement", new GetUnclaimedAchievementFunction());
        map.put("isSupportedPlatform", new IsSupportedPlatformFunction());
        map.put("getSDKVersion", new GetSDKVersionFunction());

        return map;
    }

    @Override
    public void dispose()
    {
        SessionM.getInstance().setSessionListener(null);
        SessionMExtension.log("Disposing context");
    }

    @Override
    public void onSessionStateChanged(SessionM sessionM, SessionM.State state) {
        dispatchStatusEventAsync(SESSION_STATE_CHANGED, state.toString());
    }

    @Override
    public void onSessionFailed(SessionM sessionM, int i) {
        dispatchStatusEventAsync(SESSION_FAILED, Integer.toString(i));
    }

    @Override
    public void onUserUpdated(SessionM sessionM, User user) {
        JSONObject json = null;
        try {
            json = SessionMDataUtil.userToJSON(user);
        }
        catch (JSONException e) {
            json = null;
        }
        finally {
            if(json != null) {
                dispatchStatusEventAsync(USER_UPDATED, json.toString());
            }
        }
    }

    public void onUnclaimedAchievement(SessionM sessionM, AchievementData achievementData) {
        JSONObject json = null;
        try {
            json = SessionMDataUtil.achievementToJSON(achievementData);
        }
        catch (JSONException e) {
            json = null;
        }
        finally {
            if(json != null) {
                dispatchStatusEventAsync(UNCLAIMED_ACHIEVEMENT, json.toString());
            }
        }
    }
}
