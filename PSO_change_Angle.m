clear all;
clc;
close all;

% Scenario Index :
   % 10 -> 19: Scenario 1: ve y 1, 5
   % 20 -> 29: Scenario 1: ve y 2, 6
   % 30 -> 39: Scenario 3: ve y 3, 7
   % 40 -> 49: Scenario 4: ve y 4
   
scenario_Index =39;


% Khai báo các thông so cua he thong
num_particles = 20; % so luong hat trong thuat toán PSO
max_iterations = 100; % so luong vòng lap cua thuat toán PSO


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tính thông luong kênh cho ý 2,6
% Figure 1: After PSO
if (scenario_Index >=20 && scenario_Index <= 29)
    throughput_all_AfterPSO=[]; %Vecto chua gia tri tông thong luong cho tat ca cac gia tri c?a LED semi-angle
    %returnBeforePSO = 0;
    scenario_Index = 20; % chart for angle change after PSO
    curr_max_thoughput = 0;
    angle_best = 0;
    for angle=10:2:90 %cac gia tri c?a LED semi-angle
        throughput_AfterPSO = particle_swarm_optimization_change_Angle(angle, num_particles, max_iterations, scenario_Index);
        throughput_all_AfterPSO = [throughput_all_AfterPSO throughput_AfterPSO];

        % tim goc tot nhat
        if (throughput_AfterPSO >= curr_max_thoughput)
            curr_max_thoughput = throughput_AfterPSO;
            angle_best = angle;
        end
    end
    figure(1)
    plot([10:2:90],throughput_all_AfterPSO); %Ve tong thong luong cho cac gia tri c?a LED semi-angle sau khi PSO toi uu vi tri
    title('Optimal sum capacity vesus LED semi-angle after PSO','fontsize',12)
    xlabel('LED semi-angle','fontsize',12)
    ylabel('Optimal sum capacity','fontsize',12)
    limitY = max(throughput_all_AfterPSO); 

    % Figure 1: truoc khi PSO
    throughput_all_BeforePSO=[]; %Vecto chua gia tri tông thong luong cho tat ca cac gia tri c?a LED semi-angle
    %returnbeforePSO = 1;
    scenario_Index = 21; % chart for angle change Before PSO
    for angle=10:2:90 %cac gia tri c?a LED semi-angle
        throughput_before_PSO = particle_swarm_optimization_change_Angle(angle, num_particles, max_iterations, scenario_Index);
        throughput_all_BeforePSO = [throughput_all_BeforePSO throughput_before_PSO];
    end
    figure(2)
    plot([10:2:90],throughput_all_BeforePSO); %Ve tong thong luong cho cac gia tri c?a LED semi-angle sau khi PSO toi uu vi tri
    title('Sum Capacity vesus LED semi-angle before PSO','fontsize',12)
    ylim([0 limitY])
    xlabel('LED semi-angle','fontsize',12)
    ylabel('Sum capacity','fontsize',12)
    
end % end scenario 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% chay y 1, 3, 4 ,5,7
%scenario_Index = 10;
if ((scenario_Index >=10 && scenario_Index <= 19) || (scenario_Index >=30 && scenario_Index <= 39) || (scenario_Index >=40 && scenario_Index <= 49))
    %returnbeforePSO = 0;
    angle_best = 60*pi/180;
    throughput = particle_swarm_optimization_change_Angle(angle_best, num_particles, max_iterations, scenario_Index);
    fprintf('Best Angle : %.4f\n', angle_best);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    
