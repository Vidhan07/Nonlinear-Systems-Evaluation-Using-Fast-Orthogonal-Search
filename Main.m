% Main Code for FOS
clc; close all; clear all;

n_points = 3000; % Number of points

System = 3; %1,2,or 3 Choose which system to run

x=randn(1,n_points);

% Real K and L
l = [1, 2, 2, 3, 4, 7; % L for System 1
     3, 1, 2, 3 ,4 ,9; % L for System 2
     1, 4, 1, 3, 2, 3];% L for System 3
 
k = [1, 4, 2, 3, 2, 5; % K for System 1
     2, 6, 4, 5, 1, 2; % K for System 2
     2, 1, 2, 5, 4, 8];% K for System 3

l = l(System,:); %Assign L with the correct row
k = k(System,:); %Assign K with the correct row

Order=[2,2,2,2,2,2];
percent=[0, 25, 50, 100]; %Percent of noise
  
y = Systems(System, x, n_points);%Assign y with chosen system outputs
%Plotting Input x[n] and System Output y[n]
figure('Color','white');
plot(x,'linewidth', 1, 'DisplayName', 'Input x[n]');
hold on
plot(y,'linewidth', 1, 'DisplayName', ['System ' num2str(System) ' y[n]']);
hold off
ylabel('Magnitude', 'FontSize',16)
title(['Input and System ' num2str(System) ' Output'], 'FontSize', 16)
legend('show')
grid on

%Preallocating matricies
mse_1st_magnitude = zeros(length(k),length(percent));
mse_1st_percent = zeros(length(k),length(percent));

mse_2nd_magnitude = zeros(length(k),length(percent));
mse_2nd_percent = zeros(length(k),length(percent));

mse_3rd_magnitude = zeros(length(k),length(percent));
mse_3rd_percent = zeros(length(k),length(percent));

for i=1:length(percent)
    for model=1:length(k)
        disp(['Model ' num2str(model) ' where Noise = ' num2str(percent(i)) '%']);
        
        tic
        a(model)=FOS(x,y,percent(i),k(model),l(model),Order(model),...
            n_points);
        toc
        
        mse_1st_magnitude(model,i)=a(model).mse_1st_magnitude;
        mse_1st_percent(model,i)=a(model).mse_1st_percent;
        mse_2nd_magnitude(model,i)=a(model).mse_2nd_magnitude;
        mse_2nd_percent(model,i)=a(model).mse_2nd_percent;
    end
    
    %Select Best Model Compared over 2nd Set
    [q(i),p(i)] = min(mse_2nd_magnitude(:,i));
    b(i) = a(p(i));
    
    %Print Best Model Equation to Command Window
    Print_Model(a(p(i)).Selected_candidates,a(p(i)).a,a(p(i)).K,...
        a(p(i)).L,percent(i),a(p(i)).Order,p(i));
    
    v3(i,1:1000) = Model_Output(a(p(i)).a,a(p(i)).Selected_candidates,...
        x(2001:3000),a(p(i)).K,a(p(i)).L,a(p(i)).N,a(p(i)).Order);
    
    mse_3rd_magnitude(p(i),i)=a(p(i)).mse_3rd_magnitude;
    mse_3rd_percent(p(i),i)=a(p(i)).mse_3rd_percent;

    % Figure 1-------------------------------------------
    figure('Color','white'); 
    subplot(2,1,1) %Comparing over Segment 3 2001-3000
    % Output y[n]
    plot(2001:3000,y(1,2001:3000), 'linewidth',1.35, 'DisplayName',...
        ['System ' num2str(System) ' y[n]'])
    hold on
    % Best Model z[n]
    plot(2001:3000,v3(i,1:1000), 'linewidth', 1, 'DisplayName',...
        ['Model ' num2str(p(i)) ' z[n]']);
    hold off
    ylabel('Magnitude', 'FontSize',16)
    title(['System ' num2str(System) ' and Model ' num2str(p(i))...
        ' (Noise = ' num2str(percent(i)) '%)'], 'FontSize', 16)
    legend('show')
    grid on
    
    subplot(2,1,2) %Error Plotting
    error = v3(i,1:1000)-y(1,2001:3000);
    plot(2001:3000, error, 'linewidth',1.5, 'DisplayName','Error')
    ylabel('Magnitude', 'FontSize',16)
    title('ERROR', 'FontSize', 16)
    legend('show')
    grid on
    % End of Figure 1-------------------------------------
    
    
    % Figure 2 (Zoomed of Figure 1)------------------------
    figure('Color','white'); 
    subplot(2,1,1) %Comparing over Segment 3 Zoomed 2001-2100
    % Output y[n]
    plot(2001:2100,y(1,2001:2100), 'linewidth',1.75, 'DisplayName',...
        ['System ' num2str(System) ' y[n]'])
    hold on
    % Best Model z[n]
    plot(2001:2100,v3(i,001:100), 'linewidth', 1.75, 'DisplayName',...
        ['Model ' num2str(p(i)) ' z[n]']);
    hold off
    ylabel('Magnitude', 'FontSize',16)
    title(['System ' num2str(System) ' and Model ' num2str(p(i))...
        ' (Noise = ' num2str(percent(i)) '%)  Zoomed'], 'FontSize', 16)
    legend('show')
    grid on
    
    subplot(2,1,2) %Error Plotting Zoom
    errorzoom = v3(i,001:100)-y(1,2001:2100);   
    plot(2001:2100, errorzoom, 'linewidth',2, 'DisplayName', 'Error')
    ylabel('Magnitude', 'FontSize',16)
    title('ERROR Zoomed', 'FontSize', 16)
    legend('show')
    grid on
    % End of Figure 2-----------------------------------------
    
    
end
result(1:size(k,2),1)=(1:size(k,2))';
result(1:size(k,2),2)=k';
result(1:size(k,2),3)=l';
result(1:size(k,2),4)=Order';



rr=4;
for ll=1:1:length(percent)
    rr=rr+1;
    result(:,rr)=100*percent(ll)/(percent(ll)+100);
    rr=rr+1;
    result(:,rr)=mse_1st_magnitude(:,ll);
    rr=rr+1;
    result(:,rr)=mse_1st_percent(:,ll);
    rr=rr+1;
    result(:,rr)=mse_2nd_magnitude(:,ll);
    rr=rr+1;
    result(:,rr)=mse_2nd_percent(:,ll);
    rr=rr+1;
    result(:,rr)=mse_3rd_magnitude(:,ll);
    rr=rr+1;
    result(:,rr)=mse_3rd_percent(:,ll);
end
result1=result';



