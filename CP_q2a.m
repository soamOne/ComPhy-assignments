%QUESTION 2
%driver code for three different values
format long
L1=1;V01=15;
L2=1;V02=20;
L3=3;V03=25;

EigenValues(L1,V01)
EigenValues(L2,V02)
EigenValues(L3,V03)

function EigenValues(L,V0)
    x=0.3;
    epsilon=1.0e-8;
    f=@(x)((sqrt((1-x)/x))-(tan(0.4*L*sqrt(V0*x))));
    fx=@(x)(((x - 1)/x^2 - 1/x)/(2*(-(x - 1)/x)^(1/2)) - (L*V0*(tan((2*L*(V0*x)^(1/2))/5)^2 + 1))/(5*(V0*x)^(1/2)));


    y=x-(f(x)/fx(x));
    count=1;
 
    while abs(y-x)>=epsilon
        x=y;
        f=@(x)((sqrt((1-x)/x))-(tan(0.4*L*sqrt(V0*x))));
        fx=@(x)(((x - 1)/x^2 - 1/x)/(2*(-(x - 1)/x)^(1/2)) - (L*V0*(tan((2*L*(V0*x)^(1/2))/5)^2 + 1))/(5*(V0*x)^(1/2)));
        y=x-(f(x)/fx(x));

        if count>50
            break
        end 

       count=count+1;
    end
    disp(y)

    count
end
 
