module sdl::events;

const uint EVENT_FIRST = 0;
const uint EVENT_QUIT = 0x100;
const uint EVENT_TERMINATING = 0x101;
const uint EVENT_LOW_MEMORY = 0x102;
const uint EVENT_WILL_ENTER_BACKGROUND = 0x103;
const uint EVENT_DID_ENTER_BACKGROUND = 0x104;
const uint EVENT_WILL_ENTER_FOREGROUND = 0x105;
const uint EVENT_DID_ENTER_FOREGROUND = 0x106;
const uint EVENT_LOCALE_CHANGED = 0x107;
const uint EVENT_SYSTEM_THEME_CHANGED = 0x108;
const uint EVENT_DISPLAY_ORIENTATION = 0x151;
const uint EVENT_DISPLAY_ADDED = 0x152;
const uint EVENT_DISPLAY_REMOVED = 0x153;
const uint EVENT_DISPLAY_MOVED = 0x154;
const uint EVENT_DISPLAY_DESKTOP_MODE_CHANGED = 0x155;
const uint EVENT_DISPLAY_CURRENT_MODE_CHANGED = 0x156;
const uint EVENT_DISPLAY_CONTENT_SCALE_CHANGED = 0x157;
const uint EVENT_DISPLAY_FIRST = 0x151;
const uint EVENT_DISPLAY_LAST = 0x157;
const uint EVENT_WINDOW_SHOWN = 0x202;
const uint EVENT_WINDOW_HIDDEN = 0x203;
const uint EVENT_WINDOW_EXPOSED = 0x204;
const uint EVENT_WINDOW_MOVED = 0x205;
const uint EVENT_WINDOW_RESIZED = 0x206;
const uint EVENT_WINDOW_PIXEL_SIZE_CHANGED = 0x207;
const uint EVENT_WINDOW_METAL_VIEW_RESIZED = 0x208;
const uint EVENT_WINDOW_MINIMIZED = 0x209;
const uint EVENT_WINDOW_MAXIMIZED = 0x20A;
const uint EVENT_WINDOW_RESTORED = 0x20B;
const uint EVENT_WINDOW_MOUSE_ENTER = 0x20C;
const uint EVENT_WINDOW_MOUSE_LEAVE = 0x20D;
const uint EVENT_WINDOW_FOCUS_GAINED = 0x20E;
const uint EVENT_WINDOW_FOCUS_LOST = 0x20F;
const uint EVENT_WINDOW_CLOSE_REQUESTED = 0x210;
const uint EVENT_WINDOW_HIT_TEST = 0x211;
const uint EVENT_WINDOW_ICCPROF_CHANGED = 0x212;
const uint EVENT_WINDOW_DISPLAY_CHANGED = 0x213;
const uint EVENT_WINDOW_DISPLAY_SCALE_CHANGED = 0x214;
const uint EVENT_WINDOW_SAFE_AREA_CHANGED = 0x215;
const uint EVENT_WINDOW_OCCLUDED = 0x216;
const uint EVENT_WINDOW_ENTER_FULLSCREEN = 0x217;
const uint EVENT_WINDOW_LEAVE_FULLSCREEN = 0x218;
const uint EVENT_WINDOW_DESTROYED = 0x219;
const uint EVENT_WINDOW_HDR_STATE_CHANGED = 0x21A;
const uint EVENT_WINDOW_FIRST = 0x202;
const uint EVENT_WINDOW_LAST = 0x21A;
const uint EVENT_KEY_DOWN = 0x300;
const uint EVENT_KEY_UP = 0x301;
const uint EVENT_TEXT_EDITING = 0x302;
const uint EVENT_TEXT_INPUT = 0x303;
const uint EVENT_KEYMAP_CHANGED = 0x304;
const uint EVENT_KEYBOARD_ADDED = 0x305;
const uint EVENT_KEYBOARD_REMOVED = 0x306;
const uint EVENT_TEXT_EDITING_CANDIDATES = 0x307;
const uint EVENT_MOUSE_MOTION = 0x400;
const uint EVENT_MOUSE_BUTTON_DOWN = 0x401;
const uint EVENT_MOUSE_BUTTON_UP = 0x402;
const uint EVENT_MOUSE_WHEEL = 0x403;
const uint EVENT_MOUSE_ADDED = 0x404;
const uint EVENT_MOUSE_REMOVED = 0x405;
const uint EVENT_JOYSTICK_AXIS_MOTION = 0x600;
const uint EVENT_JOYSTICK_BALL_MOTION = 0x601;
const uint EVENT_JOYSTICK_HAT_MOTION = 0x602;
const uint EVENT_JOYSTICK_BUTTON_DOWN = 0x603;
const uint EVENT_JOYSTICK_BUTTON_UP = 0x604;
const uint EVENT_JOYSTICK_ADDED = 0x605;
const uint EVENT_JOYSTICK_REMOVED = 0x606;
const uint EVENT_JOYSTICK_BATTERY_UPDATED = 0x607;
const uint EVENT_JOYSTICK_UPDATE_COMPLETE = 0x608;
const uint EVENT_GAMEPAD_AXIS_MOTION = 0x650;
const uint EVENT_GAMEPAD_BUTTON_DOWN = 0x651;
const uint EVENT_GAMEPAD_BUTTON_UP = 0x652;
const uint EVENT_GAMEPAD_ADDED = 0x653;
const uint EVENT_GAMEPAD_REMOVED = 0x654;
const uint EVENT_GAMEPAD_REMAPPED = 0x655;
const uint EVENT_GAMEPAD_TOUCHPAD_DOWN = 0x656;
const uint EVENT_GAMEPAD_TOUCHPAD_MOTION = 0x657;
const uint EVENT_GAMEPAD_TOUCHPAD_UP = 0x658;
const uint EVENT_GAMEPAD_SENSOR_UPDATE = 0x659;
const uint EVENT_GAMEPAD_UPDATE_COMPLETE = 0x65A;
const uint EVENT_GAMEPAD_STEAM_HANDLE_UPDATED = 0x65B;
const uint EVENT_FINGER_DOWN = 0x700;
const uint EVENT_FINGER_UP = 0x701;
const uint EVENT_FINGER_MOTION = 0x702;
const uint EVENT_FINGER_CANCELED = 0x703;
const uint EVENT_CLIPBOARD_UPDATE = 0x900;
const uint EVENT_DROP_FILE = 0x1000;
const uint EVENT_DROP_TEXT = 0x1001;
const uint EVENT_DROP_BEGIN = 0x1002;
const uint EVENT_DROP_COMPLETE = 0x1003;
const uint EVENT_DROP_POSITION = 0x1004;
const uint EVENT_AUDIO_DEVICE_ADDED = 0x1100;
const uint EVENT_AUDIO_DEVICE_REMOVED = 0x1101;
const uint EVENT_AUDIO_DEVICE_FORMAT_CHANGED = 0x1102;
const uint EVENT_SENSOR_UPDATE = 0x1200;
const uint EVENT_PEN_PROXIMITY_IN = 0x1300;
const uint EVENT_PEN_PROXIMITY_OUT = 0x1301;
const uint EVENT_PEN_DOWN = 0x1302;
const uint EVENT_PEN_UP = 0x1303;
const uint EVENT_PEN_BUTTON_DOWN = 0x1304;
const uint EVENT_PEN_BUTTON_UP = 0x1305;
const uint EVENT_PEN_MOTION = 0x1306;
const uint EVENT_PEN_AXIS = 0x1307;
const uint EVENT_CAMERA_DEVICE_ADDED = 0x1400;
const uint EVENT_CAMERA_DEVICE_REMOVED = 0x1401;
const uint EVENT_CAMERA_DEVICE_APPROVED = 0x1402;
const uint EVENT_CAMERA_DEVICE_DENIED = 0x1403;
const uint EVENT_RENDER_TARGETS_RESET = 0x2000;
const uint EVENT_RENDER_DEVICE_RESET = 0x2001;
const uint EVENT_RENDER_DEVICE_LOST = 0x2002;
const uint EVENT_PRIVATE0 = 0x4000;
const uint EVENT_PRIVATE1 = 0x4001;
const uint EVENT_PRIVATE2 = 0x4002;
const uint EVENT_PRIVATE3 = 0x4003;
const uint EVENT_POLL_SENTINEL = 0x7F00;
const uint EVENT_USER = 0x8000;
const uint EVENT_LAST = 0xFFFF;
const uint EVENT_ENUM_PADDING = 0x7FFFFFF;

union Event {
    uint type;
    char[<128>] __padding;
}

extern fn bool poll_event(Event *event) @extern("SDL_PollEvent");