clc
num_channel = input("Enter number of num_channels: ");% Total number of Channels
num_control= ceil(0.2*num_channel); % 20% of total allocated for control channel
fprintf("Number of control channels: %d \n",num_control);
num_traffic = num_channel - num_control;% Traffic is diff of total and control
cluster = input("Enter size of cluster: ");% Cluster size

%checking if cluster size is valid
flag=0;
for i=0:10
    for j=0:10
        if(cluster == i*i+j*j+i*j)
            flag=1;
            break
        end
    end
end

if(flag==1)
    fprintf("Cluster Size is valid \n");
    trf = zeros(cluster,ceil(num_traffic/cluster));% Ceil round number to nearest integer,traffic ,matrix
    ctrl = zeros(cluster,ceil(num_control/cluster));% zeros return mxn matrix of zeros, control matrix
    x = 1;% First traffic channel
    for i=1:ceil(num_traffic/cluster)% for loop for columns of traffic matrix
        for j=1:cluster% for loop for rows of traffic matrix
            if x<=num_traffic% conditional check till last channel
                trf(j,i) = x;
                x = x + 1;
            else
                trf(j,i) = 0;% if not satisfied then element value is 0
            end
        end
    end

    num=1+ceil(num_traffic);
    count=0;
    count2=0;
    for i=1:ceil(num_control/cluster)% for loop for columns of traffic matrix
        temp=num;
        for j=1:cluster % for loop for rows of traffic matrix
            if num<=num_channel
                ctrl(j,i)=num;
                num=num+1;
            else
                count = count + 1;
                if count<3 % Check if the channel is repeating more than 3 times
                    num = temp;
                    ctrl(j,i) = num;
                    num = num + 1;
                else
                    ctrl(j,i)=0;% Put zero if not
                    count2=count2+1;
                end
            end
        end
    end
    
    %verifying traffic channel according to control channel
    [m,n]=size(trf);
    [m1,n1]=size(ctrl);
    
    for i=1:n1
        for j=1:m1
            if(ctrl(j,i)==0)
                trf(j,i)=0;
            end
        end
    end
    
    %display fucntions
    if count2>0
        disp("Traffic Allocation Matrix") % Show traffic matrix
        disp(trf(:,1:n1))
        disp("Control Allocation Matrix")% Show control matrix
        disp(ctrl(1:(m1-count2),:))
    else
        disp("Traffic Allocation Matrix") % Show traffic matrix
        disp(trf)
        disp("Control Allocation Matrix")% Show control matrix
        disp(ctrl)
    end
else
    fprintf("Cluster Size Invalid");
end