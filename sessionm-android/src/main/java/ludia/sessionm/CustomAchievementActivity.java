package ludia.sessionm;

import android.app.Activity;
import android.util.Log;
import com.sessionm.api.AchievementData;
import com.sessionm.api.AchievementActivity;
import com.sessionm.api.AchievementActivityIllegalStateException;
import com.sessionm.api.SessionM;

import java.util.Map;

public class CustomAchievementActivity extends AchievementActivity {
    
    private static final String TAG = "ludia.sessionm.CustomAchievementActivity";
    private Activity presentingActivity;
    
    public CustomAchievementActivity(Activity activity, AchievementData achievement) {
        super(achievement);
        presentingActivity = activity;
    }
    
    public void present() {
        if (presentingActivity != null) {
            presentingActivity.runOnUiThread(new Runnable() {
                public void run() {
                    try {
                        CustomAchievementActivity.this.notifyPresented();
                        Log.d(TAG, "CustomAchievementActivity.present()");
                    } catch (AchievementActivityIllegalStateException e) {
                        Log.e(TAG, "Exception while presenting native achievement." + e);
                    }
                }
            });
        }
    }
    
    public void claim() {
        presentingActivity.runOnUiThread(new Runnable() {
            public void run() {
                try {
                    CustomAchievementActivity.this.notifyDismissed(AchievementDismissType.CLAIMED);
                    Log.d(TAG, "CustomAchievementActivity.claim()");
                } catch (AchievementActivityIllegalStateException e) {
                    Log.e(SessionM.TAG, "Exception while claiming native achievement." + e);
                }
            }
        });
    }
    
    public void dismiss() {
        presentingActivity.runOnUiThread(new Runnable() {
            public void run() {
                try {
                    CustomAchievementActivity.this.notifyDismissed(AchievementDismissType.CANCELLED);
                    Log.d(TAG, "CustomAchievementActivity.dismiss()");
                } catch (AchievementActivityIllegalStateException e) {
                    Log.e(SessionM.TAG, "Exception while dismissing native achievement." + e);
                }
            }
        });
    }
}
