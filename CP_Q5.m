
% Initialising the variables 
x1 = -pi;
xn = pi;
n1 = 10;
m1 = 101;

x = linspace(x1,xn,n1);
h = (xn-x1)/(n1-1);
b = zeros(n1-1,1);
a = zeros(n1-1,1);
b(1) = (x(2)-x(1))/h;

y = sin(2*x);
% a and b are assigned values according to the procedure of part(a) and (b)
for i = 1:n1-2
    b(i+1) = 2*(y(i+1)-y(i))/h - b(i);
    a(i) = (b(i+1) - b(i))/(2*h);
end

t1 = linspace(x1,xn,m1); 
w1 = zeros(1,m1);
% Interpolated Values for Quadratic Spline
for i = 1:m1
    n2 = 1+fix((t1(i)-x1)/h);
    if n2 == 0
        n2 = n2+1;
    end
    if n2 == n1
        n2 = n2-1;
    end
    w1(i)= a(n2)*(t1(i)-x(n2))^2 + b(n2)*(t1(i)-x(n2)) + y(n2);
end

% Code for Cubic Spline
n = 10;
z = zeros(1,n-2);

for i = 1:n-2
    z(i) = (y(i+2)-2*y(i+1)+y(i));
end

z = 6*z/(h^2);
a = [0 ones(1,n-3)];
b = 4*ones(1,n-2);
c = [ones(1,n-3) 0];

alpha=Thomas_Algo(a,b,c,z,n-2);
alpha=[0 alpha];
p=zeros(1,n-1);q=zeros(1,n-1);r=zeros(1,n-1);s=zeros(1,n-1);

for i=1:n-1
    p(i) = (alpha(i+1) - alpha(i))/(6*h);
    q(i) = alpha(i)/2;
    r(i) = (y(i+1) - y(i))/h-h*(2*alpha(i) + alpha(i+1))/6;
    s(i) = y(i);
end

t2 = linspace(x1,xn,m1); 
w2 = zeros(1,m1);
for i = 1:m1
    n2 = 1+fix((t2(i)-x1)/h);
    if n2==0
        n2 = n2+1;
    end
    if n2==n1
        n2 = n2-1;
    end
    w2(i) = p(n2)*(t2(i)-x(n2))^3+q(n2)*(t2(i)-x(n2))^2+r(n2)*(t2(i)-x(n2))+s(n2);
end

subplot(1,1,1)
plot(t1,w1,'b','linewidth',1.5)
hold on
plot(t1,sin(2*t1),'r','linewidth',1.5)
hold off

subplot(1,1,1)

%function for Thomas Algorithm 
function x = Thomas_Algo(a,b,c,d,n)
    p(1)=-c(1)/b(1) ; q(1)=d(1)/b(1);
    x=zeros(1,n+1);
    for k=2:n
        denom = b(k)+ a(k)*p(k-1);
        p(k)=-c(k)/denom;
        q(k)=(d(k)-a(k)*q(k-1))/denom;

    end
   for k = n:-1:1
       x(k)= p(k)*x(k+1)+q(k);

   end
end