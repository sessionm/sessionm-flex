package sessionm.flex.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sessionm.api.SessionM;
import sessionm.flex.SessionMExtension;

public class LogDebugFunction implements FREFunction{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        SessionMExtension.log("LogDebugFunction.call()");
        String msg = readAliasFromArgument(freObjects);

        SessionMExtension.log(msg);
        return null;
    }

    private String readAliasFromArgument(FREObject[] freObjects)
    {
        String msg = null;

        try
        {
            msg = freObjects[0].getAsString();
        }
        //Exception of type FREInvalidObjectException, FREWrongThreadException or  FRETypeMismatchException
        catch (Exception e)
        {
            SessionMExtension.logError("Couldn't retrieve debug message : " + e.getMessage());
        }
        finally
        {
            return msg;
        }
    }

}
