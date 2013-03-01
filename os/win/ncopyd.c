/**
 * This program listens on port 2224 of localhost for TCP connections.
 *
 * When a client connects it will receive all incoming information with the
 * assumption that it is text in the UTF-8 encoding. It will then convert this
 * text to the native windows wide character encoding and place it on the
 * clipboard as unicode text.
 *
 * The intended use case is an ssh session that has remote forwarding enabled
 * and specified that port 2224 should be routed to the local machine's port
 * 2224. Then from the console the user can use netcat to send any text or
 * documents to the local machines clipboard for easy use.
 *
 * Example:
 *   cat somefile.c | nc localhost 2224
 *   # the contents of somefile.c are on the clipboard ready for pasting
 *
 * Compile:
 *   x86_64-w64-mingw32-gcc --std=c99 -static -m64 ncopyd.c -O3 -lwsock32 -o ncopyd.exe -mwindows -Wall -pedantic
 *
 * Copyright (C) 2013 Chris Hoffman
 *
 * This is provided "AS-IS" with no warranty. The only requirement is the
 * copyright be maintained as a reference if any substantial portions of the
 * code are used.
 **/
#include <winsock2.h>
#include <windows.h>
#include <stdio.h>
#include <inttypes.h>

int CopyToClipboardFromSocket(SOCKET *);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow) {
  WSADATA data;
  SOCKET sock;

  int error = WSAStartup(MAKEWORD(2, 2), &data);
  if (error) {
    perror("Foobared the startup");
  }

  struct sockaddr_in addr;
  memset(&addr, 0, sizeof(addr));

  addr.sin_family = AF_INET;
  addr.sin_port = htons(2224);
  addr.sin_addr.s_addr = inet_addr("127.0.0.1");

  sock = socket(AF_INET, SOCK_STREAM, 0);
  if (sock == INVALID_SOCKET) {
    perror("Foobared the socket");
  }

  if (bind(sock, (LPSOCKADDR)&addr, sizeof(addr)) == SOCKET_ERROR) {
    closesocket(sock);
    WSACleanup();
    perror("Foobared the bind");
  }

  // Only makes sense to get one connection at a time since we modify a global
  // clipboard state and there is only one of those.
  listen(sock, 1);

  while (1) {
    SOCKET conn = accept(sock, 0, 0);
    if (conn == INVALID_SOCKET) {
      closesocket(sock);
      WSACleanup();
      perror("Socket accept failed");
    }

    CopyToClipboardFromSocket(&conn);
  }

  // Will never actually be reached because no shutdown hooks are registered
  if (sock) closesocket(sock);
  WSACleanup();

  return 0;
}

int CopyToClipboardFromSocket(SOCKET *sock) {
  char buf[1024], *text = (char *)malloc(sizeof(buf));
  uint32_t realsize = 0, rawsize = sizeof(buf);

  if (!text) {
    perror("failed allocating memory to receive message");
  }

  while (1) {
    int result = recv(*sock, buf, sizeof(buf), 0);

    if (result == 0) {
      break;
    }

    if (result == SOCKET_ERROR) {
      fprintf(stderr, "failed to read from socket %d", WSAGetLastError());
      return 1;
    }

    printf("got %d bytes ", result);

    // If the new needed size for text is larger than the currently allocated
    // amount grow the allocated amount by double its size to amortize the
    // amount of calls needed.
    if (realsize + result >= rawsize) {
      printf("reallocating text to %u bytes ", rawsize << 1);
      rawsize = rawsize << 1;
      text = (char *)realloc(text, rawsize);
      if (!text) {
        perror("failed reallocating enough memory for message");
      }
    }

    // Copy the new data into what we have received
    memcpy(text + realsize, buf, result);

    // Track how much actual text we have received
    realsize += result;

    printf("have %u bytes\n", realsize);
  }

  // Set the last byte of the text to null to terminate it
  *(text + realsize++) = '\0';

  closesocket(*sock);

  int size = MultiByteToWideChar(CP_UTF8,
                                 0, // Must be 0 for UTF8,
                                 text,
                                 realsize,
                                 NULL,
                                 0);

  if (!size) {
    fprintf(stderr, "Could not determine length for wide char conversion\n");
    free(text);
    return 1;
  }

  wchar_t *final_text = (wchar_t *)malloc(sizeof(wchar_t) * size);
  if (!final_text) {
    perror("failed allocating memory for conversion string");
  }

  DWORD result = MultiByteToWideChar(CP_UTF8,
                                     0, // Must be 0 for UTF8,
                                     text,
                                     realsize,
                                     final_text,
                                     size);

  if (!result) {
    fprintf(stderr, "Could not convert string to wide char");
    free(text);
    return 2;
  }

  // No longer need text now that it has been converted
  free(text);

  HGLOBAL hGlobal;    // Global memory handle

  // Open clipboard using current process as owner
  OpenClipboard(NULL);

  // Empty clipboard so new contents can be placed
  EmptyClipboard();

  // Allocate the memory for the string.
  hGlobal = GlobalAlloc(GMEM_MOVEABLE | GMEM_ZEROINIT, sizeof(wchar_t)*size);
  if (!hGlobal) return 1;

  // Lock the global memory and copy our final_text into the area
  memcpy(GlobalLock(hGlobal), final_text, sizeof(wchar_t)*size);

  // Release lock now that memory has been altered
  GlobalUnlock(hGlobal);

  // Tell clipboard were the new data is and the format
  SetClipboardData(CF_UNICODETEXT, hGlobal);

  // Release the clipboard
  CloseClipboard();

  free(final_text);

  return 0;
}
