function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        JUMP,
        DOWN,
        LEFT,
        RIGHT,
        ACCEPT,
        CANCEL,
        ACTION,
        SPECIAL,
        PAUSE,
        MAP,
		DASH,
		GLIDE
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        MOVEMENT,
    }
    
    InputDefineVerb(INPUT_VERB.JUMP,	"jump",			[vk_space, vk_up],	[-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,	"down",			vk_down,			[ gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,	"left",			vk_left,			[-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,	"right",		vk_right,			[ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.DASH,	"dash",			vk_shift,			[ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.GLIDE,	"glide",		[vk_space, vk_up],	[ gp_axislh, gp_padr]);
    
	if (INPUT_ON_SWITCH_X)
    {
        //Flip A/B over on Switch
        InputDefineVerb(INPUT_VERB.ACCEPT, "accept", undefined, gp_face2); // !!
        InputDefineVerb(INPUT_VERB.CANCEL, "cancel", undefined, gp_face1); // !!
    }
    else
    {
        InputDefineVerb(INPUT_VERB.ACCEPT, "accept", ord("E"),     gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL, "cancel", vk_backspace, gp_face2);
    }
    
    if (INPUT_ON_PS5)
    {
        //`gp_select` is inaccessible on PS5
        InputDefineVerb(INPUT_VERB.MAP, "map", vk_backspace, gp_touchpadbutton);
    }
    else
    {
        InputDefineVerb(INPUT_VERB.MAP, "map", vk_backspace, gp_select);
    }
    
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.MOVEMENT, INPUT_VERB.JUMP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
