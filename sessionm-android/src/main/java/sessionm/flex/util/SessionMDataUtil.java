package sessionm.flex.util;

import com.sessionm.api.AchievementData;
import com.sessionm.api.User;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Date;

public class SessionMDataUtil {

    public static JSONObject achievementToJSON(AchievementData achievementData) throws JSONException {
        JSONObject json = new JSONObject();
        json.put("name", achievementData.getName());
        json.put("message", achievementData.getMessage());
        json.put("action", achievementData.getAction());
        json.put("mpointValue", achievementData.getMpointValue());
        json.put("achievementIconURL", achievementData.getAchievementIconURL());
        json.put("isCustom", achievementData.isCustom());
        Date lastEarnedDate = achievementData.lastEarnedDate();
        json.put("lastEarnedDate", (lastEarnedDate == null) ? 0 : lastEarnedDate.getTime());
        return json;
    }

    public static JSONObject userToJSON(User user) throws JSONException {
        JSONObject json = new JSONObject();
        json.put("pointBalance", user.getPointBalance());
        json.put("unclaimedAchievementCount", user.getUnclaimedAchievementCount());
        json.put("unclaimedAchievementValue", user.getUnclaimedAchievementValue());
        json.put("optedOut", user.isOptedOut());
        return  json;
    }
}
