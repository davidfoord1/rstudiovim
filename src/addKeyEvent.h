// addKeyEvent.h
#ifndef ADDKEYEVENT_H
#define ADDKEYEVENT_H

#include <windows.h>
#include <vector>

// Helper function to add a key event to the inputs vector
inline void addKeyEvent(std::vector<INPUT>& inputs, WORD vk, DWORD flags = 0) {
  INPUT input = { 0 };
  input.type = INPUT_KEYBOARD;
  input.ki.wVk = vk;
  input.ki.dwFlags = flags;
  inputs.push_back(input);
}

#endif // ADDKEYEVENT_H
