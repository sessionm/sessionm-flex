package sessionm.flex.data {
/**
 * Lists the possible session state values.
 */
public final class State {
    /**
     * Used when a session has stopped.
     *
     * @public
     */
    public static const STOPPED:String = "STOPPED";
    /**
     * Used when a session is starting.
     *
     * @public
     */
    public static const STARTING:String = "STARTING";
    /**
     * Used when a session has started online.
     *
     * @public
     */
    public static const STARTED_ONLINE:String = "STARTED_ONLINE";
    /**
     * Used when a session has started offline.
     *
     * @public
     */
    public static const STARTED_OFFLINE:String = "STARTED_OFFLINE";
    /**
     * Used when a session is stopping.
     *
     * @public
     */
    public static const STOPPING:String = "STOPPING";
}
}
