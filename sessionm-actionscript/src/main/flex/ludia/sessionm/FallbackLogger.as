package ludia.sessionm {
/**
 * Contains functionality for logging to the Adobe AIR console (to be used
 * when a definition for mx.logging.Log cannot be found).
 */
public class FallbackLogger {
    /**
     * The FallbackLogger constructor.
     *
     * @public
     */
    public function FallbackLogger() {
    }

    /**
     * Calls <code>log</code> to print debug messages.
     *
     * @public
     * @param msg
     * @param args (optional)
     * @see #log()
     */
    public function debug(msg:String, ...args):void {
        log("[DEBUG]", msg, args);
    }

    /**
     * Calls <code>log</code> to print warning messages.
     *
     * @public
     * @param msg
     * @param args (optional)
     * @see #log()
     */
    public function warn(msg:String, ...args):void {
        log("[WARN]", msg, args);
    }

    /**
     * Calls <code>log</code> to print info messages.
     *
     * @public
     * @param msg
     * @param args (optional)
     * @see #log()
     */
    public function info(msg:String, ...args):void {
        log("[INFO]", msg, args);
    }

    /**
     * Calls <code>log</code> to print error messages.
     *
     * @public
     * @param msg
     * @param args (optional)
     * @see #log()
     */
    public function error(msg:String, ...args):void {
        log("[ERROR]", msg, args);
    }

    /**
     * Calls <code>log</code> to print fatal messages.
     *
     * @public
     * @param msg
     * @param args (optional)
     * @see #log()
     */
    public function fatal(msg:String, ...args):void {
        log("[FATAL]", msg, args);
    }

    /**
     * Invoked by the other logging methods. Use this method to print general
     * messages.
     *
     * @public
     * @param level the tag to be prepended to the log message in the console.
     * @param msg the message to be printed to the console.
     * @param args a key-value map from <code>String</code> to
     * <code>String</code>. The keys are substrings of <code>msg</code> that
     * will be replaced by their mapped values. Note: the keys must be placed
     * between curly braces ( <code>{}</code> ) in <code>msg</code> in order to
     * be replaced.
     */
    public function log(level:String, msg:String, args:Array):void {
        for(var p:String in args) {
            msg = msg.replace("{"+p+"}", args[p]);
        }
        trace(level, msg);
    }
}
}
