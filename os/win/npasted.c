/**
 * This program listens on port 2225 of localhost for TCP connections.
 *
 * When a client connects it will get the current clipboard contents and send
 * them to the client in a utf-8 encoding.
 *
 * The intended use case is an ssh session that has remote forwarding enabled
 * and specified that port 2225 should be routed to the local machine's port
 * 2225. Now the console can use the local machine's clipboard in pipes.
 *
 * Example:
 *   nc localhost 2225 > somefile.c
 *   # the contents of somefile.c contain the contents of the clipboard
 *
 * Compile:
 *   x86_64-w64-mingw32-gcc --std=c99 -static -m64 npasted.c -O3 -lwsock32 -o npasted.exe -mwindows -Wall -pedantic
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

int CopyFromClipboardToSocket(SOCKET *);

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
  addr.sin_port = htons(2225);
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

  listen(sock, SOMAXCONN);

  while (1) {
    SOCKET conn = accept(sock, 0, 0);
    if (conn == INVALID_SOCKET) {
      closesocket(sock);
      WSACleanup();
      perror("Socket accept failed");
    }

    CopyFromClipboardToSocket(&conn);

    closesocket(conn);
  }

  // Will never actually be reached because no shutdown hooks are registered
  if (sock) closesocket(sock);
  WSACleanup();

  return 0;
}

int CopyFromClipboardToSocket(SOCKET *sock) {
  // Open clipboard using current process as owner
  OpenClipboard(NULL);

  wchar_t *text = (wchar_t *)GetClipboardData(CF_UNICODETEXT);
  if (!text) {
    return 1;
  }

  DWORD size = WideCharToMultiByte(CP_UTF8,
                                   0,
                                   text,
                                   -1,
                                   NULL,
                                   0,
                                   NULL,
                                   NULL);
  if (!size) {
    fprintf(stderr, "failed to get length for UTF-8 string\n");
    CloseClipboard();
    return 1;
  }
  
  char *final_text = (char *)calloc(size, sizeof(char));
  DWORD result = WideCharToMultiByte(CP_UTF8,
                                     0,
                                     text,
                                     -1,
                                     final_text,
                                     size,
                                     NULL,
                                     NULL);
  if (!result) {
    fprintf(stderr, "failed to recode string to UTF-8\n");
    CloseClipboard();
    free(final_text);
    return 1;
  }

  // Release the clipboard
  CloseClipboard();

  // Send the clipboard across
  send(*sock, final_text, size, 0);

  free(final_text);

  return 0;
}
