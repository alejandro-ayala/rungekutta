#include <iostream>

using namespace std;
int func(int x, int y);
int runge_kutta_k1(int input1,int input2,int step);
int runge_kutta_k2(int input1,int input2, int input_k1, int step);

int main()
{
    int input1 = 0x23;
    int input2 = 0x23;
    int step = 0x1;
    int input_k1 = 0x823;
    
    int k1_result = runge_kutta_k1(input1,input2,step);
    cout<< "\nresult_k1= " << std::hex << k1_result;

    int k2_result = runge_kutta_k2(input1,input2,input_k1,step);
    cout<< "\nresult_k2= " << std::hex << k2_result;
    
    return 0;
}

int runge_kutta_k1(int input1,int input2,int step)
{
    int k1= func(input1,input2);
    int result = k1*step;
    return result;
}

int runge_kutta_k2(int input1,int input2, int input_k1, int step)
{
    int k2= func(input1+step,input2+input_k1);
    int result = k2*step;
    return result;
}
int func(int x, int y)
{
    int res = (y*y-x*x)+(y*y+x*x);
    return res;
}