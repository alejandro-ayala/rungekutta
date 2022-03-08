#include <iostream>

using namespace std;
int func(int x, int y);
int runge_kutta_k1(int input1,int input2,int step);
int runge_kutta_k2(int input1,int input2, int input_k1, int step);
int runge_kutta_k3(int input1,int input2, int input_k2, int step);
int runge_kutta_k4(int input1,int input2, int input_k3, int step);

int main()
{
    int input1 = 0x23;
    int input2 = 0x23;
    int step = 0x1;
    int input_k1 = 0x823;
    int input_k2 = 0x3;
    int input_k3 = 0x3;
    
    int k1_result = runge_kutta_k1(input1,input2,step);
    cout<< "\nresult_k1= " << std::hex << k1_result;

    int k2_result = runge_kutta_k2(input1,input2,input_k1,step);
    cout<< "\nresult_k2= " << std::hex << k2_result;

    input1 = 0x0000001;
    input2 = 0x1000001;
    int k3_result = runge_kutta_k3(input1,input2,input_k2,step);
    cout<< "\nresult_k3= " << std::hex << k3_result;
 
    input1 = 0x0000001;
    input2 = 0x00000C1;
    int k4_result = runge_kutta_k4(input1,input2,input_k3,step);
    cout<< "\nresult_k4= " << std::hex << k4_result;    
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

int runge_kutta_k3(int input1,int input2, int input_k2, int step)
{
    int k3= func(input1+step,input2+input_k2);
    int result = k3*step;
    return result;
}

int runge_kutta_k4(int input1,int input2, int input_k3, int step)
{
    int k4= func(input1+(2*step),input2+input_k3);
    int result = k4*step;
    return result;
}
int func(int x, int y)
{
    int res = (y*y-x*x)+(y*y+x*x);
    return res;
}