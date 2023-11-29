function f_function=Optimal_function_distance_Capacity_change_Angle(angle,d_,x1_,x2_,isDrawBarForS1, isDrawPositionForS4) %Nhap gia tri cua d, x1, x2 de co gia tri dau ra.
%Tham so he thông
theta=angle;% semi-angle at half power
m=-log(2)/log(cos(theta));%Lambertian order of emission
P_total=2;%transmitted optical power by individual LED
Adet=0.0001;%detector physical area of a PD
Ts=1;%gain of an optical filter; ignore if no filter is used
index=1;%refractive index of a lens at a PD; ignore if no lens is used
FOV=60*pi/180;%FOV of a receiver
G_Con=(index^2)/sin(FOV);%gain of an optical concentrator; ignore if no lens is used
h=2;%kho?ng cách gi?a LEDs và PD theo tr?c z (chi?u cao)


%V? trí (x,y) c?a các LEDs%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Layout hình 4(a) nh?ng có 4 c?m LED, m?i c?m có 4x4=16 LEDs.
d=d_; %Khoang cách giua các LED trong 1 cum
x1=x1_; %Khoang cách giua các c?m LED theo truc x
y1=x2_; %Khoang cách giua các cum LED theo truc y

%4x4 LEDs (x,y) for one clutter, 4 clutters in the room
%Location of one clutter (4 LEDs)
tx=[-d-d/2 -d/2 d/2 d+d/2]; %Toa do x
ty=[-d-d/2 -d/2 d/2 d+d/2]; %Toa do y
[tx,ty]=meshgrid(tx,ty);
tx=reshape(tx,1,[]); %Vecto toa do x cua 1 cum LED
ty=reshape(ty,1,[]); %Vecto toa do y cua 1 cum LED

%Location (x,y) of four clutters (16 LEDs)
tx=[tx-x1/2 tx+x1/2];
tx=[tx tx]; %Vecto toa do x cua ca 4 cum LED
ty=[ty ty];
ty=[ty-y1/2 ty+y1/2]; %Vecto toa do y cua ca 4 cum LED

%Các vi trí cua 4 user, moi user su dung 1 PD%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tai mat phang cua máy thu, khao sát tai moi diem su dung 1 PD
rx=[-1.5 0 1 0.6]; %Các vi trí PD de khao sát cách nhau 0.2m
ry=[0.3 1.2 -0.8 -2]; %Các vi trí PD de khao sát cách nhau 0.2m
%scatter(rx,ry) %Lenh ve toa do cua tat ca các PDs

% check neu can ve hinh 4a
if (isDrawPositionForS4 == 1)
    figure(1)
    scatter(tx,ty) %Lenh ve hình nhu hình 4
    xlim([min(tx)*1.2 max(tx)*1.2])
    ylim([min(ty)*1.2 max(ty*1.2)])
    title('Vi tri toi uu cua LED - Before PSO','fontsize',17)
    
    figure(2)
    scatter(rx,ry) %Lenh ve hình nhu hình 4
    xlim([min(rx)*1.2 max(rx)*1.2])
    ylim([min(ry)*1.2 max(ry*1.2)])
    title('Vi tri cua cac User - Before PSO','fontsize',17)
end


% check neu can ve hinh 4a - After PSO
if (isDrawPositionForS4 == 2)
    figure(3)
    scatter(tx,ty) %Lenh ve hình nhu hình 4
    xlim([min(tx)*1.2 max(tx)*1.2])
    ylim([min(ty)*1.2 max(ty*1.2)])
    title('Vi tri toi uu cua LED - After PS0','fontsize',17)
    
    figure(4)
    scatter(rx,ry) %Lenh ve hình nhu hình 4
    xlim([min(rx)*1.2 max(rx)*1.2])
    ylim([min(ry)*1.2 max(ry*1.2)])
    title('Vi tri cua cac User - After PS0','fontsize',17)
end


%Tính channel gain, chi tính LOS, bo qua nLOS
H_all=zeros(1,length(rx)); %Khoi tao vector cho channel gain cua tat ca các vi trí trong phòng
for i=1:length(rx) %Calculate each row of channel matrix (contain channel gain between i-th LED and all PDs
    D1=sqrt((rx(i)-tx).^2+(ry(i)-ty).^2+h^2);%distance Between all LED and i-th PDs vector form)
    cosphi_A1=h./D1;%Cos of Phi-Angle (vector form)
    H_A1=(m+1)*Adet.*cosphi_A1.^(m+1)./(2*pi.*D1.^2);
    H=P_total.*H_A1.*Ts.*G_Con; %channel gain calculation
    
    %sum all elements to get received power at i-th location
    H_all(i)=sum(H);
end

noise=10^-6; %Công suat nhieu
capacity=log(1+H_all/noise);

% f_function=min(capacity) %Ham 1: Ham muc toi da hoa Capacity toi thieu cua cac user
f_function=sum(capacity) %Ham 2: Ham muc tieu de toi da hoa tong Capacity cua ca 4 user 

% Draw capacity cua 4 user - Scenario 1 
if isDrawBarForS1 == 1
    bar(capacity) %Hinh 1: Ve capacity cua ca 4 user
end

