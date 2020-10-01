%QUESTION 3
format short

f1=@(x,y,z) x^2+y^2+z^2-3;
f2=@(x,y,z) x^2+y.^2+z.^2-(4*sqrt(x.^2+y.^2))+3;
f3=@(x,y,z) x+y+z;
f1x=@(x,y,z) 2*x;
f1y=@(x,y,z) 2*y;
f1z=@(x,y,z) 2*z;
f2x=@(x,y,z)2*x - (4*x)/(x^2 + y^2)^(1/2);
f2y=@(x,y,z) 2*y - (4*y)/(x^2 + y^2)^(1/2);
f2z=@(x,y,z) 2*z;
f3x=@(x,y,z)1;
f3y=@(x,y,z)1;
f3z=@(x,y,z)1;

distance=@(x,y) sqrt(((x-y)')*(x-y));

 
x=[-1;-1;-1];
epsilon=1.0e-8;

J=[f1x(x(1),x(2),x(3)),f1y(x(1),x(2),x(3)),f1z(x(1),x(2),x(3));...
   f2x(x(1),x(2),x(3)),f2y(x(1),x(2),x(3)),f2z(x(1),x(2),x(3));...
   f3x(x(1),x(2),x(3)),f3y(x(1),x(2),x(3)),f3z(x(1),x(2),x(3))];
 
y=x-(pinv(J)*[f1(x(1),x(2),x(3));f2(x(1),x(2),x(3));f3(x(1),x(2),x(3))]);

d=distance(x,y);
count=1;

 
while d >= epsilon
    
    x=y;
    J=[f1x(x(1),x(2),x(3)),f1y(x(1),x(2),x(3)),f1z(x(1),x(2),x(3));...
    f2x(x(1),x(2),x(3)),f2y(x(1),x(2),x(3)),f2z(x(1),x(2),x(3));...
    f3x(x(1),x(2),x(3)),f3y(x(1),x(2),x(3)),f3z(x(1),x(2),x(3))];
 
    y=x-(pinv(J)*[f1(x(1),x(2),x(3));f2(x(1),x(2),x(3));f3(x(1),x(2),x(3))]);
    count=count+1;
    d=distance(x,y);
 
    if count>=100
       break
    end    
end
y
[f1(y(1),y(2),y(3)),f2(y(1),y(2),y(3))];

count