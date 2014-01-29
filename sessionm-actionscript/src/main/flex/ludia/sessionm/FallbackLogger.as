package ludia.sessionm {
public class FallbackLogger {
    public function FallbackLogger() {
    }

    public function debug(msg:String, ...args):void {
        log("[DEBUG]", msg, args);
    }

    public function warn(msg:String, ...args):void {
        log("[WARN]", msg, args);
    }

    public function info(msg:String, ...args):void {
        log("[INFO]", msg, args);
    }

    public function error(msg:String, ...args):void {
        log("[ERROR]", msg, args);
    }

    public function fatal(msg:String, ...args):void {
        log("[FATAL]", msg, args);
    }

    public function log(level:String, msg:String, args:Array):void {
        for(var p:String in args) {
            msg = msg.replace("{"+p+"}", args[p]);
        }
        trace(level, msg);
    }
}
}
