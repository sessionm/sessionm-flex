package ludia.sessionm;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import com.sessionm.api.ActivityListener;
import com.sessionm.api.BaseActivity;
import com.sessionm.api.SessionM;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

public class InitActivityActivity extends BaseActivity{

    private static final String TAG = "ludia.sessionm.InitActivityActivity";

    public static String ACTIVITY_PRESENTED = "ACTIVITY_PRESENTED";
    public static String ACTIVITY_DISMISSED = "ACTIVITY_DISMISSED";
    public static String ACTIVITY_UNAVAILABLE = "ACTIVITY_UNAVAILABLE";
    public static String USER_ACTION = "USER_ACTION";

    private SessionM.ActivityType type;
    private boolean presented;

    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Log.d(TAG, "InitActivityActivity.onCreate()");
        this.type = SessionM.ActivityType.valueOf(getIntent().getStringExtra("ACT_TYPE"));
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Log.d(TAG, "InitActivityActivity.onNewIntent()");
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.d(TAG, "InitActivityActivity.onStart()");
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.d(TAG, "InitActivityActivity.onRestart()");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.d(TAG, "InitActivityActivity.onResume() presented=" + presented);
        if(!this.presented) {
            SessionM.getInstance().presentActivity(type);
            this.presented = true;
        }
        else {
//            SessionM.getInstance().dismissActivity();
            this.presented = false;
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.d(TAG, "InitActivityActivity.onPause()");
    }

    @Override
    protected void onStop() {
        super.onStop();
        Log.d(TAG, "InitActivityActivity.onStop()");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "InitActivityActivity.onDestroy()");
    }

    @Override
    public void onPresented(SessionM sessionM) {
        Log.d(TAG, "InitActivityActivity.onPresented()");
        SessionMExtension.context.dispatchStatusEventAsync(ACTIVITY_PRESENTED, "");
    }

    @Override
    public void onDismissed(SessionM sessionM) {
        Log.d(TAG, "InitActivityActivity.onDismissed()");
        SessionMExtension.context.dispatchStatusEventAsync(ACTIVITY_DISMISSED, "");
        finish();
    }

    @Override
    public void onUnavailable(SessionM sessionM) {
        Log.d(TAG, "InitActivityActivity.onUnavailable()");
        SessionMExtension.context.dispatchStatusEventAsync(ACTIVITY_UNAVAILABLE, "");
        finish();
    }

    @Override
    public void onUserAction(SessionM sessionM, UserAction userAction, Map<String, String> stringStringMap) {
        Log.d(TAG, "InitActivityActivity.onUserAction()");
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
