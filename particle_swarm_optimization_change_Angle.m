% Dinh nghia hàm tính thông luong kênh cho toàn bo tap hat
function throughput = particle_swarm_optimization_change_Angle(angle, num_particles, max_iterations, scenario_Index)
    isDrawBarForS1 = 0; % Mac dinh ko ve bar cho ý 1
    isDrawPositionForS4 = 0 % Mac dinh k ve toa do cua Leds

    % Khoi tao tap hat
    d_ = 1 + rand(num_particles,1);
    x1_ = 1 + rand(num_particles,1)*9;
    x2_ = 1 + rand(num_particles,1)*9;
    
    particle_position = [d_, x1_, x2_]; %tao ra vi trí particle (d_ x1_ x2_)
    particle_best_position = particle_position;
    particle_best_value = zeros(num_particles, 1);
    throughput_i= zeros(1,max_iterations);
    interations_i= zeros(1,max_iterations);
    % Thuat toan Heuristic ( Centroid Based Method)
    % Tính toán vi trí moi cua các hat trong quá trình toi uu hóa
    C_d_ = 3.5;
    C_x1_ = 5.5;
    C_x2_ = 5.5;
    throughput_C= zeros(1,max_iterations);
    for i = 1:num_particles
        particle_best_value(i) = Optimal_function_distance_Capacity_change_Angle(angle, particle_position(i, 1),particle_position(i, 2),particle_position(i, 3), isDrawBarForS1, isDrawPositionForS4);
    end
    [global_best_value, global_best_index] = max(particle_best_value);
    global_best_position = particle_best_position(global_best_index, :);
    % Thuc hien thuat toán PSO
    velocity = zeros(num_particles, 3);
    for iteration = 1:max_iterations
        for i = 1:num_particles
            % Cap nhat van toc
            inertia_weight = 0.9;
            cognitive_weight = 1;
            social_weight = 2;
            velocity(i, :) = inertia_weight * velocity(i, :) + cognitive_weight * rand(1, 3).* (particle_best_position(i, :) - particle_position(i, :)) + social_weight * rand(1, 3) .* (global_best_position - particle_position(i, :));
            % Cap nhat vi trí
            particle_position(i, :) = particle_position(i, :) + velocity(i, :);
            % Dam bao gioi han giá tri cua vi trí
            % Tính giá tri hàm muc tiêu moi
            new_value = Optimal_function_distance_Capacity_change_Angle(angle, particle_position(i, 1),particle_position(i, 2),particle_position(i, 3), isDrawBarForS1, isDrawPositionForS4);
            % So sánh voi giá tri tot nhat cua hat
            if new_value > particle_best_value(i)
            particle_best_value(i) = new_value;
            particle_best_position(i, :) = particle_position(i, :);            
            end
        end
%         % ve sum of cap sau moi particle
%         plot(particle_best_value);
%         disp(particle_position);

        % So sánh voi giá tri tot nhat cua tap hat
        [iteration_best_value, iteration_best_index] = max(particle_best_value);
        if iteration_best_value > global_best_value
            global_best_value = iteration_best_value;
            global_best_position = particle_best_position(iteration_best_index, :);
        end
        throughput_i(1,iteration) = global_best_value;
        throughput_C(1,iteration) = Optimal_function_distance_Capacity_change_Angle(angle, C_d_,C_x1_,C_x2_, isDrawBarForS1, isDrawPositionForS4);
        interations_i(1, iteration) = iteration;
    end

throughput = global_best_value;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % v? ý 1, 5
   if (scenario_Index >=10 && scenario_Index <= 19)
       isDrawPositionForS4 = 0;
       isDrawBarForS1 = 1;
       if (isDrawBarForS1 == 1)
           %Before PSO
           figure(1);
           hold on;
           d_org = d_(1);
           x1_org = x1_(1);
           x2_org = x2_(1);
           Optimal_function_distance_Capacity_change_Angle(angle, d_org,x1_org,x2_org, isDrawBarForS1, isDrawPositionForS4);
           title('Capacity of 4 Users - Before PSO','fontsize',17);
           xlabel('User','fontsize',13);
           ylabel('Capacity','fontsize',13);
          
           % After PSO
           figure(2);
           hold on;
           d_best = global_best_position(1, 1);
           x1_best = global_best_position(1, 2);
           x2_best = global_best_position(1, 3);
           Optimal_function_distance_Capacity_change_Angle(angle, d_best,x1_best,x2_best, isDrawBarForS1, isDrawPositionForS4);
           title('Capacity of 4 Users - After PSO','fontsize',17);
           xlabel('User','fontsize',13) ;
           ylabel('Capacity','fontsize',13);
%            % Add a common title for both figures
%            suptitle('Capacity of 4 Users - Before and After PSO','fontsize',20);
       end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % sau PSO - default
    d_best = global_best_position(1, 1);
    x1_best = global_best_position(1, 2);
    x2_best = global_best_position(1, 3);
    throughput = Optimal_function_distance_Capacity_change_Angle(angle, d_best,x1_best,x2_best, isDrawBarForS1, isDrawPositionForS4);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data cho ý 2,6: 
%     %truoc PSO
    if (scenario_Index == 21) % Lay du lieu cho Sum Cap Before PSO
        d_org = d_(1);
        x1_org = x1_(1);
        x2_org = x2_(1);    
        throughput_before_PSO = Optimal_function_distance_Capacity_change_Angle(angle,d_org,x1_org,x2_org, isDrawBarForS1, isDrawPositionForS4);
        throughput = throughput_before_PSO; % dùng cho y 2,6 + before PSO only
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ve y 3,7: 
if (scenario_Index >=30 && scenario_Index <= 39)
    isDrawBarForS1 = 0; 
     % ve toa do truoc khi toi uu pso
    d_org = d_(1);
    x1_org = x1_(1);
    x2_org = x2_(1);
    isDrawPositionForS4 = 1;    
    Optimal_function_distance_Capacity_change_Angle(angle,d_org,x1_org,x2_org, isDrawBarForS1, isDrawPositionForS4);
    
    %ve toa do sau khi toi uu PSO
    d_best = global_best_position(1, 1);
    x1_best = global_best_position(1, 2);
    x2_best = global_best_position(1, 3);
    isDrawPositionForS4 = 2;    
    Optimal_function_distance_Capacity_change_Angle(angle,d_best,x1_best,x2_best, isDrawBarForS1, isDrawPositionForS4);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%v? ý 4
    if (scenario_Index >=40 && scenario_Index <= 49)
       isDrawBarForS4 = 1;
       if(isDrawBarForS4 == 1)
           hold on;
           plot(interations_i, throughput_i);
           title('Sum Capacity for each interation','fontsize',17);
           xlabel('Interation Index','fontsize',13) 
           ylabel('Sum Capacity','fontsize',13)
           hold off;
       end
    end
end

