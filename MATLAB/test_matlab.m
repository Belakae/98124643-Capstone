%% Load Data

% file1 = importdata('CoM_1.txt',' ',1);
% file2 = importdata('CoM_2.txt',' ',1);
% file3 = importdata('CoM_3.txt',' ',1);
% file4 = importdata('CoM_4.txt',' ',1);
% file5 = importdata('CoM_5.txt',' ',1);
% file6 = importdata('CoM_6.txt',' ',1);
% file7 = importdata('CoM_7.txt',' ',1);
% file8 = importdata('CoM_8.txt',' ',1);
% file9 = importdata('CoM_9.txt',' ',1);
% file10 = importdata('CoM_10.txt',' ',1);
% file11 = importdata('visc.txt',' ',1);
% file12 = importdata('zero.txt',' ',1);
% 
% com_1 = file1.data;
% com_2 = file2.data;
% com_3 = file3.data;
% com_4 = file4.data;
% com_5 = file5.data;
% com_6 = file6.data;
% com_7 = file7.data;
% com_8 = file8.data;
% com_9 = file9.data;
% com_10 = file10.data;
% visc = file11.data;
% zero = file12.data;

%% Read Matrix

com_1_raw = readmatrix('CoM_1.txt');
com_2_raw = readmatrix('CoM_2.txt');
com_3_raw = readmatrix('CoM_3.txt');
com_4_raw = readmatrix('CoM_4.txt');
com_5_raw = readmatrix('CoM_5.txt');
com_6_raw = readmatrix('CoM_6.txt');
com_7_raw = readmatrix('CoM_7.txt');
com_8_raw = readmatrix('CoM_8.txt');
com_9_raw = readmatrix('CoM_9.txt');
com_10_raw = readmatrix('CoM_10.txt');
visc_raw = readmatrix('visc.txt');
zero_raw = readmatrix('zero.txt');

%% Format Data and Remove Outliers

com_1_data = rmoutliers(com_1_raw(3:end),'mean');
com_2_data = rmoutliers(com_2_raw(3:end),'mean');
com_3_data = rmoutliers(com_3_raw(3:end),'mean');
com_4_data = rmoutliers(com_4_raw(3:end),'mean');
com_5_data = rmoutliers(com_5_raw(3:end),'mean');
com_6_data = rmoutliers(com_6_raw(3:end),'mean');
com_7_data = rmoutliers(com_7_raw(3:end),'mean');
com_8_data = rmoutliers(com_8_raw(3:end),'mean');
com_9_data = rmoutliers(com_9_raw(3:end),'mean');
com_10_data = rmoutliers(com_10_raw(3:end),'mean');

visc_data = rmoutliers(visc_raw(2:end),'mean');
zero_data = rmoutliers(zero_raw(2:end),'mean');

% Get the mean of each data array

com_1_mean = mean(com_1_data)
com_2_mean = mean(com_2_data)
com_3_mean = mean(com_3_data)
com_4_mean = mean(com_4_data)
com_5_mean = mean(com_5_data)
com_6_mean = mean(com_6_data)
com_7_mean = mean(com_7_data)
com_8_mean = mean(com_8_data)
com_9_mean = mean(com_9_data)
com_10_mean = mean(com_10_data)

zero_mean = mean(zero_data)



%% Knowns

% Radius(mm)
R = 30.15;
% Angle(degrees)
theta = -20.2861*pi/180;

%% Unknowns

% Volume
V = 0;

% Height
h = 0;

%% Case 1: Bottom face covered, top face dry

% Solving Volume
V = (pi*R^2)*((h/cos(theta)) - 2*R*tan(theta)) + (pi*R^3)*tan(theta);

% Solving x_B
x_B = ((pi*R^4)/(4*V))*tan(theta);

% Solving y_B
a = (R*tan(theta)+(h/cos(theta))-(2*R*tan(theta)))^2;
b = (0.5*pi*R^2);
c = ((tan(theta).^2)*(0.125*pi*R^4));

y_B = (1/V)*((a*b)+c);

x_l = x_B*cos(theta) + y_B*sin(theta) - 200*sin(theta)

%% Case 2: Bottom Face partially covered, top face dry

alpha = R - (h/sin(theta));
beta = sqrt((R^2) - (alpha^2));

% Solving Volume

a = ((2*beta^3)/3);
b = (pi*R^2)/2;
c = alpha*beta;
d = (R^2)*atan(alpha/beta);

V = tan(theta)*(a - alpha*(b - c - d));

% Solving x_B

a = (pi*R^4)/2;
b = alpha*beta*(2*alpha^2 - R^2);
c = (R^4)*atan(alpha/beta);
d = (2*alpha*beta^3)/3;

x_B = (1/V)*tan(theta)*(0.25*(a - b - c) - d);

% Solving y_B

a = (tan(theta).^2)/V;
b = (alpha^2)/2;
c = ((pi*R^4)/2) - (alpha*beta) - (R^2)*atan(alpha/beta);
d = ((pi*R^4)/2) - (alpha*beta)*((2*alpha^2)-(R^2)) - (R^4)*atan(alpha/beta);
e = (2*alpha*beta^3)/3;

y_B = a*(b*(c) + 0.125*(d) - e);

x_l = x_B*cos(theta) + y_B*sin(theta) - 200*sin(theta)

%% Load Data Test

%[com,visc,zero] = load_data();


% CoM_size = CoM(1);
% CoM_angles = CoM(2:CoM_size+2); %Change when the # of angles matches the # of readings
% CoM_data = CoM(end-CoM_size+1:end);
% 
% Visc_size = Visc(1);
% Visc_data = Visc(2:end);

%% Test function with switch cases (theta, R, Lg, h(unknown),method)

%x_l = find_CoM([45*pi/180],48.35,200,49,0)


% It will select the most appropriate value for the volume from the two
% generated

% Setting up initial variables

Tz = 0.1719; %Nm
g = 9.81;
mc = 0.336; %kg
L = 0.260; %m
Lg = 0.160; %m
R = 0.03015; %m

theta = -20.2861*pi/180;
ml = 0.139; %kg


%fun_1 = (Tz - g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h,1)));   
%fun_2 = @(h_1)(Tz - g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h_2,2)));

fplot(@(h) (Tz - g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h,1))), [0 0.2]);

grid on

h = 0;
ans = (Tz - g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h,1)))


V = (pi*R^2)*((0.0106152/cos(theta)) - 2*R*tan(theta)) + (pi*R^3)*tan(theta)
 %x0 = 0;
 %x = lsqnonlin(fun_1,x0)

% fun = @(h)(g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h,1)));
% 
% 
% 
% goal = Tz;
% 
% weight = 1;
% 
% h0 = 0;
% 
% h = fgoalattain(fun,h0,goal,weight)
% 
% answer = (g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h,1)))




% for (int i = 0; i<data_size; i++)
%     
%     % Set up the changing variables
%     
%     Tz = CoM_data(i);
%     theta = Angle_data(i);
%     
%     h_1 = fminbnd(fun_1,0,200);
%     
%     h_2 = fminbnd(fun_2,0,200);
%     
%     % It will then select which value for h is the best ? (figure out how
%     % it will tell)
% end


% fun = @(h)(Tz - g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h,1)));
% 
% h = fminbnd(fun_1,0,200);
% 
% answer = (Tz - g*(a + ml*find_CoM(theta,R,Lg,h,1)))

% Look at extra options for the fminbnd function, can plot results

% fun_1 = @(h_1)(Tz - g*(mc*((L/2)-Lg)*sin(theta) + ml*find_CoM(theta,R,Lg,h_1,1)));
% 
% 





