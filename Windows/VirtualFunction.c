/*
// ISC DHCPd 4.x for Windows (with Cygwin) patch
//	(C)2016 Dark Network Systems
//	http://dark-x.net/
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define HW_TYPE_IPMP	255
#define HW_ADDR_LEN	20

struct hwinfo {	//struct hardware in "common/socket.c"
	unsigned char Length;
	unsigned char Addr[HW_ADDR_LEN + 1];
};

void get_hw_addr(void *UnUsed01, struct hwinfo *hw){
	hw->Length = sizeof(hw->Addr);
	srandom( time(0) );

	hw->Addr[0] = HW_TYPE_IPMP;
	for (int i = 1; i < hw->Length; ++i) {
		hw->Addr[i] = random() % 256;
	}

	return;
}
