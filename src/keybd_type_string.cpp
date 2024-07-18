#include <Rcpp.h>
#include <windows.h>
#include <string>
#include <vector>
#include "addKeyEvent.h"
using namespace Rcpp;

// Helper function to handle modifier keys
void handleModifiers(std::vector<INPUT>& inputs,
                     bool shift,
                     bool ctrl,
                     bool alt,
                     bool keyUp = false) {
  DWORD flags = keyUp ? KEYEVENTF_KEYUP : 0;

  if (shift) addKeyEvent(inputs, VK_SHIFT,   flags);
  if (ctrl)  addKeyEvent(inputs, VK_CONTROL, flags);
  if (alt)   addKeyEvent(inputs, VK_MENU,    flags);
}

// [[Rcpp::export]]
void keybd_type_string(std::string input) {
  std::vector<INPUT> inputs;

  for (char c : input) {
    SHORT vk = VkKeyScan(c);

    if (vk == -1) {
      Rcpp::stop("Unsupported character: " + std::string(1, c));
    }

    // Modifiers in high-order byte
    bool shift = vk & 0x0100;
    bool ctrl = vk & 0x0200;
    bool alt = vk & 0x0400;

    // Virtual key code in low-order byte
    vk = vk & 0xFF;

    // Press modifier keys
    handleModifiers(inputs, shift, ctrl, alt);

    // Press and release the key
    addKeyEvent(inputs, vk);                  // Key down
    addKeyEvent(inputs, vk, KEYEVENTF_KEYUP); // Key up

    // Release modifier keys
    handleModifiers(inputs, shift, ctrl, alt, true);
  }

  SendInput(inputs.size(), &inputs[0], sizeof(INPUT));
}
