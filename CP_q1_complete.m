%driver code
%Q1(a)
x0=5;
a=1498.9;
N=2000;
randnums=randgen(x0,a,N,-1000);
h=histogram(randnums,100);
dist_mean=compMean(randnums)
dist_variance=stdDev(randnums).^2

%Q1 b,c
arr_new=randgen(x0,a,100,0);
sorted_arr=arr_sort(arr_new)
M=compMean(sorted_arr)
SD=stdDev(sorted_arr)
minimum=sorted_arr(1)
maximum=sorted_arr(numel(sorted_arr))

function A=randgen(x0,a,N,start)
    A=zeros([1,500]);
    A(1)=x0;
    for i=2:499
        A(i)=mod((A(i-1))*a,N)+start;
    
    end
end

function arr=arr_sort(arr)
    for i = (2:numel(arr))
 
        value = arr(i);
        j = i - 1;
 
        while (j >= 1) && (arr(j) > value)
            arr(j+1) = arr(j);
            j = j-1;
        end
 
        arr(j+1) = value;
    end
    
end

function arr_mean=compMean(arr)
    sum=0;
    for i=1:numel(arr)
        sum=sum+arr(i);
    end
    arr_mean=sum/numel(arr);
    
end

function SD=stdDev(arr)
    m=compMean(arr);
    diffSqrd=0;
    for i=1:numel(arr)
        diffSqrd=diffSqrd+((arr(i)-m)*(arr(i)-m));
    end
    var=diffSqrd/numel(arr);
    SD=sqrt(var);
end
