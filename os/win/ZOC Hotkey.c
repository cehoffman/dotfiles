// Compile: x86_64-w64-mingw32-gcc -m64 hotkey.c -mwindows -O3 -o "Zoc HotKey.exe"
#include <stdio.h>
/* #include <time.h> */
#include <wtypes.h>
#include <winuser.h>

#ifndef MOD_NOREPEAT
#define MOD_NOREPEAT 0x4000
#endif

int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow) {
  MSG message = {0};
  HWND current, zoc, previous = NULL;
  int hotkey;

  // Randomize because
  srand((unsigned int)time(NULL));

  // Register hotkey
  hotkey = rand();
  BOOL ret = RegisterHotKey(NULL, hotkey, MOD_NOREPEAT, VK_F1);

  // Start the message loop
  while(GetMessage(&message, NULL, 0, 0) > 0) {
    if (message.message == WM_QUIT) {
      break;
    }

    if (message.message == WM_HOTKEY) {
      int key = (message.lParam >> 16) & 0xffffffff;
      if (VK_F1 != key) {
        continue;
      }

      // find the zoc window
      if (!(zoc = FindWindow("ZocMainWindow", NULL))) {
        // if it doesn't exist just skip the message
        continue;
      }

      current = GetForegroundWindow();
      if (current == zoc) {
        if (previous) {
          SetForegroundWindow(previous);
        }
      } else {
        previous = current;
        SetForegroundWindow(zoc);
      }
    }
  }

  UnregisterHotKey(NULL, hotkey);

  return message.wParam;
}
