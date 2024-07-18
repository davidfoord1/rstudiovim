#include <Rcpp.h>
#include <windows.h>
#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>
#include "addKeyEvent.h"

// Map key names to virtual key codes
std::unordered_map<std::string, WORD> keyMap = {
  {"Ctrl", VK_CONTROL}, {"Shift", VK_SHIFT}, {"Alt", VK_MENU},
  {"Esc", VK_ESCAPE}, {"Tab", VK_TAB}, {"Enter", VK_RETURN},
  {"Up", VK_UP}, {"Down", VK_DOWN}, {"Left", VK_LEFT}, {"Right", VK_RIGHT},
  {"1", 0x31}, {"2", 0x32}, {"3", 0x33}, {"4", 0x34},
  {"5", 0x35}, {"6", 0x36}, {"7", 0x37}, {"8", 0x38},
  {"9", 0x39}, {"0", 0x30}
  // TODO: Add more keys as needed
};

// [[Rcpp::export]]
void keybd_press(std::string input) {
  std::vector<INPUT> keyDownInputs;
  std::vector<INPUT> keyUpInputs;
  std::istringstream iss(input);
  std::string token;

  // Parse the input string
  while (std::getline(iss, token, '+')) {
    auto it = keyMap.find(token);
    if (it != keyMap.end()) {
      addKeyEvent(keyDownInputs, it->second); // Key down
      addKeyEvent(keyUpInputs, it->second, KEYEVENTF_KEYUP); // Key up
    } else {
      Rcpp::stop("Unsupported key: " + token);
    }
  }

  // Check if keyDownInputs are generated
  if (keyDownInputs.empty()) {
    Rcpp::stop("No valid keys found in input.");
  }

  // Send the key down events
  UINT result = SendInput(keyDownInputs.size(), &keyDownInputs[0], sizeof(INPUT));
  if (result != keyDownInputs.size()) {
    Rcpp::stop("SendInput failed for key down.");
  }

  // Send the key up events
  result = SendInput(keyUpInputs.size(), &keyUpInputs[0], sizeof(INPUT));
  if (result != keyUpInputs.size()) {
    Rcpp::stop("SendInput failed for key up.");
  }
}
