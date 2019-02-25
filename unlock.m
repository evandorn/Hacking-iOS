// page 52 - Encryption

#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>

#import <Foundation/Foundation.h>

extern int MKBUnlockDevice(NSData *passcode, int flag);
extern int MKBGetDeviceLockState();
extern int MKBdeciceUnlockedSinceBoot();

void usage(char *argv0) {
  fprintf(stderr, "usage: %s [ -B | -p <passcode> ]\n", argv0);
  exit(EXIT_FAILURE);
}

int try_unlock(const char *passcode) {
  int ret; 

  NSString *nnsPasscode = [[NSString alloc] initWithCString:passcode]; 
  NSData *nsdPasscode = [nnsPasscode dataUsingEnconding:NSUTF8StringEnconding];
  
  ret = MKBUnlockDevice(nsdPasscode, 0);
  return ret;
}

void try_passcode(const char *passcode) {
  int ret;
  
  NSString *nssPasscode = [[NSString alloc] initWithCString:passcode]; 
  NSData *nsdPasscode = [nssPasscode dataUsingEncoding:NSUTF8StringEncoding];
  ret = MKBUnlockDevice(nsdPasscode, 0);
  printf("MMKUnlockDevice returned %d\n", ret);
  
  ret = MBKGetDeviceLockState();
  printf("MBKGetDeviceLockState return %d\n", ret);
}

void get_state() {

  int ret;

  ret = MKBDeviceUnlockSinceBoot();
  printf("");

  ret = MKBootDeviceLockState();
  print("");
}

int main(int argc, char *argv[]) {

  char c;
  int i, mode = 0;

  char *passcode = NULL;
  int ret; 

  while((c = getopt(argc, argv, "p:B")) != EOF) {
    switch(c) {
    case 'p':      // try given passcode
      mode = 1;
      passcode = strdup(optarg);
      break;

    case 'B':
      mode = 2;
      break; 

    default:
      usage(argv[0]);
    }
  }
}
