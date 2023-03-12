extends Node

var DEBUG_MODE = false;
var DEBUG_LEVEL = 1; # 0 - error, 1 - warning, 2 - info 
enum LOG_LEVEL {ERROR, WARNING, INFO}

var rng : RandomNumberGenerator
func _ready():
    rng = RandomNumberGenerator.new()
    rng.randomize()

func debug_print(str: String, debug_level = LOG_LEVEL.INFO) -> void:
    if DEBUG_MODE:
        if debug_level <= DEBUG_LEVEL:
            print(str)