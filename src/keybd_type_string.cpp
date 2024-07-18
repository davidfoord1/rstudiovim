#include <Rcpp.h>
#include <windows.h>
#include <string>
#include <vector>
#include "addKeyEvent.h"
using namespace Rcpp;

// [[Rcpp::export]]
void keybd_type_string(std::string input) {
  std::vector<INPUT> inputs;

  for (char c : input) {
    SHORT vk = VkKeyScan(c);

    if (vk == -1) {
      Rcpp::stop("Unsupported character: " + std::string(1, c));
    }

    // Check if Shift is needed using HIBYTE
    bool shift = HIBYTE(vk) & 1;

    // Virtual key code in low-order byte using LOBYTE
    vk = LOBYTE(vk);

    // Press Shift if needed
    if (shift) {
      addKeyEvent(inputs, VK_SHIFT);
    }

    // Press and release the key
    addKeyEvent(inputs, vk);                  // Key down
    addKeyEvent(inputs, vk, KEYEVENTF_KEYUP); // Key up

    // Release Shift if it was pressed
    if (shift) {
      addKeyEvent(inputs, VK_SHIFT, KEYEVENTF_KEYUP);
    }
  }

  SendInput(inputs.size(), &inputs[0], sizeof(INPUT));
}
