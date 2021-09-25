channel_num=input("Enter the total number of channels: ");
cluster_num=input("Enter the cluster size: ");

%checking if cluster size is valid
flag=0;
for i=0:10
    for j=0:10
        if(cluster_num == i*i+j*j+i*j)
            flag=1;
            break
        end
    end
end
if(flag==1)
    fprintf("Enter %d channel demands\n",cluster_num);
    demand=zeros(1,cluster_num);
    total_demand=0;

    for i=1:cluster_num
        demand(i)=input("Enter:");
        total_demand=total_demand+demand(i);    
    end

    percentage=zeros(1,cluster_num);
    for p=1:cluster_num
        per = (channel_num*demand(p))/total_demand;
        percentage(p) = round(per);
    end

    high_low=mod( reshape(randperm(1*channel_num), 1, channel_num),2 ); %randperm random permutation of 1 and 0

    arr = zeros(1,channel_num);
    h=zeros(1,channel_num);
    l=zeros(1,channel_num);
    y=zeros(cluster_num,max(demand));
    mlow=1;
    nlow=1;
    n=channel_num;

    for i=1:channel_num
        if (high_low(i)==1) %if 1 assign to high
            arr(mlow) = i;
            h(mlow)=i;
            mlow=mlow+1;
        else %if 0 assign to low
            arr(n) = i;
            l(nlow)=i;
            nlow=nlow+1;
            n = n -1;
        end
    end

    %Counting non zero entries
    non=nnz(high_low);
    high=zeros(1,non);
    for i=1:non
        high(i)=h(i);
    end

    low=zeros(1,channel_num-non);
    j=1;
    num = non + 1;

    for i=1:non
        low(j)=l(i);
        j=j+1;
    end
    
    disp("High Priority Channels")
    disp(high)
    disp("Low Priority Channels")
    disp(low)
    disp("Number of calls per channel using percentage")
    disp(percentage)
    
    curr=1;
    last = max(demand);
    
    for i=1:last
        for j=1:cluster_num
            if(i>percentage(j))
                continue
            end
            if(curr<=channel_num)
                y(j,i)=arr(curr);
            else
                break;
            end
            curr=curr+1;
        end
    end

    disp("Dynamic Channel Allotment")
    disp(y)
    disp("Total demand")
    disp(total_demand)
    disp("Input")
    disp(channel_num)
else
    fprintf("Cluster Size Error");
end