package ludia.sessionm;

import android.os.Bundle;
import com.sessionm.api.ActivityListener;
import com.sessionm.api.BaseActivity;
import com.sessionm.api.SessionM;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

public class PresentActivityActivity extends BaseActivity{

    public static String ACTIVITY_PRESENTED = "ACTIVITY_PRESENTED";
    public static String ACTIVITY_DISMISSED = "ACTIVITY_DISMISSED";
    public static String ACTIVITY_UNAVAILABLE = "ACTIVITY_UNAVAILABLE";
    public static String USER_ACTION = "USER_ACTION";

    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        SessionM.ActivityType type = SessionM.ActivityType.valueOf(getIntent().getStringExtra("ACT_TYPE"));
        SessionM sessionM = SessionM.getInstance();
        if (sessionM.getSessionState() == SessionM.State.STARTED_ONLINE) {
            sessionM.presentActivity(type);
        }
    }

    @Override
    public void onPresented(SessionM sessionM) {
        SessionMExtension.context.dispatchStatusEventAsync(ACTIVITY_PRESENTED, "");
    }

    @Override
    public void onDismissed(SessionM sessionM) {
        SessionMExtension.context.dispatchStatusEventAsync(ACTIVITY_DISMISSED, "");
        finish();
    }

    @Override
    public void onUnavailable(SessionM sessionM) {
        SessionMExtension.context.dispatchStatusEventAsync(ACTIVITY_UNAVAILABLE, "");
    }

    @Override
    public void onUserAction(SessionM sessionM, UserAction userAction, Map<String, String> stringStringMap) {
        super.onUserAction(sessionM, userAction, stringStringMap);

        JSONObject jsonObject = null;

        try {
            jsonObject = new JSONObject();
            jsonObject.put("userAction", userAction.toString());
            jsonObject.put("achievementName", stringStringMap.get(ActivityListener.UserActionAchievementNameKey));
            jsonObject.put("sponsorContentName", stringStringMap.get(ActivityListener.UserActionSponsorContentNameKey));
            jsonObject.put("pageName", stringStringMap.get(ActivityListener.UserActionPageNameKey));
            jsonObject.put("rewardName", stringStringMap.get(ActivityListener.UserActionRewardNameKey));
        }
        catch (JSONException e) {
            jsonObject = null;
        }
        finally {
            if(jsonObject != null) {
                SessionMExtension.context.dispatchStatusEventAsync(USER_ACTION, jsonObject.toString());
            }
        }
    }
}
