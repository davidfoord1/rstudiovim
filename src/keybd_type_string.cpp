#include <Rcpp.h>
#include <windows.h>
#include <string>
#include <vector>
using namespace Rcpp;

// Helper function to add a key event to the inputs vector
void addKeyEvent(std::vector<INPUT> & inputs, WORD vk, DWORD flags = 0) {
  INPUT input = { 0 };
  input.type = INPUT_KEYBOARD;
  input.ki.wVk = vk;
  input.ki.dwFlags = flags;
  inputs.push_back(input);
}

// [[Rcpp::export]]
void keybd_type_string(std::string input) {
  std::vector<INPUT> inputs;

  for (char c : input) {
    SHORT vk = VkKeyScan(c);
    if (vk == -1) {
      Rcpp::stop("Unsupported character");
    }

    bool shift = vk & 0x0100;
    bool ctrl = vk & 0x0200;
    bool alt = vk & 0x0400;
    vk = vk & 0xFF;

    if (shift) addKeyEvent(inputs, VK_SHIFT);
    if (ctrl) addKeyEvent(inputs, VK_CONTROL);
    if (alt) addKeyEvent(inputs, VK_MENU);

    addKeyEvent(inputs, vk);           // Key down
    addKeyEvent(inputs, vk, KEYEVENTF_KEYUP); // Key up

    if (alt) addKeyEvent(inputs, VK_MENU, KEYEVENTF_KEYUP);
    if (ctrl) addKeyEvent(inputs, VK_CONTROL, KEYEVENTF_KEYUP);
    if (shift) addKeyEvent(inputs, VK_SHIFT, KEYEVENTF_KEYUP);
  }

  SendInput(inputs.size(), &inputs[0], sizeof(INPUT));
}