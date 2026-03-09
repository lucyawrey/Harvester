// Feather disable all

function __InputVerbGroupsConfig()
{
    //Whether verbs should be blocked if *any* of their verb groups are inactive. If you set this macro
    //to `false` then a verb will only be blocked if *all* of its verb groups are inactive.
    #macro VERB_GROUP_INACTIVE_ON_ANY  false
    
    enum VERB_GROUP
    {
        //EXAMPLE_A,
        //EXAMPLE_B,
        
        //Add your own verb groups here!
    }
    
    //If you add a verb group in the `VERB_GROUP` enum then you should add a call to
    //`InputVerbGroupDefine` here.
    //
    // N.B. Any verb not in at least one verb group will be considered as being in every verb group for
    //      the purposes of finding binding collisions.
    
    //InputVerbGroupDefine(VERB_GROUP.EXAMPLE_A, [VERB.UP, VERB.DOWN, VERB.LEFT, VERB.RIGHT, VERB.ACCEPT, VERB.CANCEL]);
    //InputVerbGroupDefine(VERB_GROUP.EXAMPLE_B, [VERB.ACTION, VERB.SPECIAL]);
}