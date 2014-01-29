/**
 * Created with IntelliJ IDEA.
 * User: sboichon
 * Date: 13-11-01
 * Time: 12:25
 * To change this template use File | Settings | File Templates.
 */
package {

/** Quick and dirty code to show a simple UI in the sample application ***/
/** Inline Command */
class Command
{
    /** Callback Method */
    private var fnCallback:Function;

    /** Label */
    private var label:String;

    //
    // Public Methods
    //

    /** Create New Command */
    public function Command(label:String,fnCallback:Function)
    {
        this.fnCallback=fnCallback;
        this.label=label;
    }

    //
    // Command Implementation
    //

    /** Get Label */
    public function getLabel():String
    {
        return label;
    }

    /** Execute */
    public function execute():void
    {
        fnCallback();
    }
}
}