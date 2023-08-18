#include<stdio.h>
#include<math.h>

int main()
{
	unsigned long long int a;
	long long int b_max,b_min;
	a = (unsigned long long int)(pow(2,64)-1);
	b_max = (long long int)(pow(2,63)-1);
	b_min = (long long int)(pow(2,63)*(-1));
	printf("The max value of 64 bit unsigned number is %llu\n The max number of 64 bit signed number is %lld\n The min value of 64 bit signed number is %lld\n",a,b_max,b_min);
	return 0;

}
