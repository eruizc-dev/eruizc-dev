#include "keymap.h"

data_t session_data = {
    .system = LINUX
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [DEFAULT] = LAYOUT_split_3x6_3(
        KC_GESC, KC_Q, KC_W, KC_E, KC_R, KC_T,                  KC_Y, KC_U, KC_I, KC_O, KC_P, KC_BSPC,
        KC_TAB, KC_A, KC_S, KC_D, KC_F, KC_G,                   KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOT,
        KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B,                  KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH, KC_RSFT,
        KC_LCTL, KC_SPC, LT(NUMBER, KC_NO),                     LT(SYMBOL, KC_NO), RGUI_T(KC_ENT), KC_LALT
    ),
    [NUMBER] = LAYOUT_split_3x6_3(
        KC_GRV, KC_1, KC_2, KC_3, KC_4, KC_5,                   KC_6, KC_7, KC_8, KC_9, KC_0, KC_TRNS,
        KC_TRNS, KC_LT, KC_LBRC, KC_LCBR, KC_LPRN, KC_PMNS,     KC_PPLS, KC_RPRN, KC_RCBR, KC_RBRC, KC_GT, KC_BSLS,
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_UNDS,   KC_PEQL, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
        KC_TRNS, KC_TRNS, KC_TRNS,                              LT(SPECIAL, KC_NO), KC_TRNS, KC_TRNS
    ),
    [SYMBOL] = LAYOUT_split_3x6_3(
        KC_TILD, KC_EXLM, KC_AT, KC_HASH, KC_DLR, KC_PERC,      KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_DELETE,
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,   KC_LEFT, KC_DOWN, KC_UP, KC_RGHT, KC_TRNS, KC_TRNS,
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,   KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
        KC_TRNS, KC_TRNS, LT(SPECIAL, KC_NO),                   KC_TRNS, KC_TRNS, KC_TRNS
    ),
    [SPECIAL] = LAYOUT_split_3x6_3(
        RESET, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5,               KC_F6, KC_F7, KC_F8, KC_F9, KC_F10, CODE,
        LOAD_VIMRC, KC_F11, KC_F12, KC_F13, KC_F14, KC_F15,     KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_BTN1, KC_TRNS,
        CHANGE_SYSTEM_PREV, KC_UNDO, KC_CUT, KC_COPY, KC_PSTE, KC_TRNS,    KC_PSCR, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, CHANGE_SYSTEM_NEXT,
        KC_TRNS, KC_TRNS, KC_TRNS,                              KC_TRNS, KC_TRNS, KC_TRNS
    ),
    //[TRNS] = LAYOUT_split_3x6_3(
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    //    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,           KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
    //    KC_TRNS, KC_TRNS, KC_TRNS,                                      KC_TRNS, KC_TRNS, KC_TRNS
    //)
};

const uint16_t PROGMEM both_shifts_combo[] = { KC_LSHIFT, KC_RSHIFT, COMBO_END };
const uint16_t PROGMEM ctrl_alt_combo[] = { KC_LALT, KC_LCTRL, COMBO_END };

combo_t key_combos[COMBO_COUNT] = {
    COMBO(both_shifts_combo, KC_CAPSLOCK),
    COMBO(ctrl_alt_combo, KC_RALT),
};

#ifdef OLED_ENABLE
oled_rotation_t oled_init_user(oled_rotation_t rotation) {
    return OLED_ROTATION_270;
}

void render_left(void) {
    static const char PROGMEM mac_upper[] = { 0x95, 0x96, 0 };
    static const char PROGMEM mac_lower[] = { 0xb5, 0xb6, 0 };
    static const char PROGMEM windows_upper[] = { 0x97, 0x98, 0 };
    static const char PROGMEM windows_lower[] = { 0xb7, 0xb8, 0 };
    static const char PROGMEM linux_upper[] = { 0x99, 0x9a, 0 };
    static const char PROGMEM linux_lower[] = { 0xb9, 0xba, 0 };
    static const char PROGMEM android_upper[] = { 0x9b, 0x9c, 0 };
    static const char PROGMEM android_lower[] = { 0xbb, 0xbc, 0 };

    oled_write_P(mac_upper,  == MAC);
    oled_write_P(PSTR(" "), false);
    oled_write_P(windows_upper, session_data.system == WINDOWS);
    oled_write_P(mac_lower, session_data.system == MAC);
    oled_write_P(PSTR(" "), false);
    oled_write_P(windows_lower, session_data.system == WINDOWS);
    oled_write_P(PSTR("     "), false);
    oled_write_P(linux_upper, session_data.system == LINUX);
    oled_write_P(PSTR(" "), false);
    oled_write_P(android_upper, session_data.system == ANDROID);
    oled_write_P(linux_lower, session_data.system == LINUX);
    oled_write_P(PSTR(" "), false);
    oled_write_P(android_lower, session_data.system == ANDROID);
}

void render_right(void) {
    oled_write_ln_P(PSTR("Right"), false);
}

void oled_task_user(void) {
    if (is_keyboard_master()) {
        render_left();
    } else {
        render_right();
    }
}
#endif

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (keycode == LOAD_VIMRC && record->event.pressed) {
        SEND_STRING("echo \"" VIMRC "\" > /tmp/.vimrc && alias vim='vim -u /tmp/.vimrc'");
    }
    if (keycode == CODE && record->event.pressed) {
        SEND_STRING("e7I(i1N(r7I!c1R(e5T*");
    }
    if (keycode == CHANGE_SYSTEM_PREV && record->event.pressed) {
        session_data.system = session_data.system > 0 ? session_data.system - 1 : 3;
    }
    if (keycode == CHANGE_SYSTEM_NEXT && record->event.pressed) {
        session_data.system = session_data.system < 3 ? session_data.system + 1 : 0;
    }
    return true;
};
