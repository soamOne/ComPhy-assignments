%QUESTION 4
%driver code
a=-2;b=6;
n=15;
x=linspace(a,b,n);
r= (b-a).*rand(1,n) + a;
CurveFit(a,b,r,x,n)

function alpha=GE(B,C)
    [row,col] = size(B);
    n = row;
    alpha = zeros(size(C));
    for k = 1:n-1   
        for i = k+1:n
            xMultiplier = B(i,k) / B(k,k);
            for j=k+1:n
                B(i,j) = B(i,j) - xMultiplier * B(k,j);
            end
            C(i, :) = C(i, :) - xMultiplier * C(k, :);
        end
    end
    % backsubstitution:
    alpha(n, :) = C(n, :) / B(n,n);
    for i = n-1:-1:1
        summation = C(i, :);
        for j = i+1:n
            summation = summation - B(i,j) * alpha(j, :);
        end
        alpha(i, :) = summation / B(i,i);
    end
end
    

function CurveFit(a,b,r,x,n)
    p0=@(x) 1
    p1=@(x) x
    p2=@(x) x.^2
    p3=@(x) x.^3
    p4=@(x) x.^4
    p5=@(x) x.^5
    f=@(x) x.^5.+x.^3
    m=6;
    y=f(x)+ 0.1*r;
    A=zeros(m,n);B=zeros(m,n);C=zeros(m,n);D=zeros(m,n);
    for k=1:n
        A(1,k)=p0(x(k)); A(2,k)=p1(x(k)); A(3,k)=p2(x(k)); A(4,k)=p3(x(k));
        A(5,k)=p4(x(k)); A(6,k)=p5(x(k))
    end
    B=A*A';
    C=A*y';
    alpha=GE(B,C);
    t=linspace(a,b,100);
    z=alpha(1)*p0(t)+alpha(2)*p1(t)+alpha(3)*p2(t)+alpha(4)*p3(t)...
      +alpha(5)*p4(t)+alpha(6)*p5(t)
    plot(t,z,'linewidth',1.0)
    hold on
    plot(x,y,'*')
    grid on
    
end