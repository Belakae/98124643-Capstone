
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

%% Seperate size and angle from data

com_1_angle = com_1_raw(1);
com_1_size = com_1_raw(2);

com_2_angle = com_2_raw(1);
com_2_size = com_2_raw(2);

com_3_angle = com_3_raw(1);
com_3_size = com_3_raw(2);

com_4_angle = com_4_raw(1);
com_4_size = com_4_raw(2);

com_5_angle = com_5_raw(1);
com_5_size = com_5_raw(2);

com_6_angle = com_6_raw(1);
com_6_size = com_6_raw(2);

com_7_angle = com_7_raw(1);
com_7_size = com_7_raw(2);

com_7_angle = com_7_raw(1);
com_7_size = com_7_raw(2);

com_8_angle = com_8_raw(1);
com_8_size = com_8_raw(2);

com_9_angle = com_9_raw(1);
com_9_size = com_9_raw(2);

com_10_angle = com_10_raw(1);
com_10_size = com_10_raw(2);

zero_size = zero_raw(1);


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


%% Plot the Raw and processed data

figure1 = figure
plot(com_1_raw(3:end),'b')
title('CoM 1 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_1_data,'g')
yline(com_1_mean,'k--','Mean')
title('CoM 1 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com1raw.jpg');
saveas(figure2,'com1processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_2_raw(3:end),'b')
title('CoM 2 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_2_data,'g')
yline(com_2_mean,'k--','Mean')
title('CoM 2 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com2raw.jpg');
saveas(figure2,'com2processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_3_raw(3:end),'b')
title('CoM 3 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_3_data,'g')
yline(com_3_mean,'k--','Mean')
title('CoM 3 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com3raw.jpg');
saveas(figure2,'com3processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_4_raw(3:end),'b')
title('CoM 4 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_4_data,'g')
yline(com_4_mean,'k--','Mean')
title('CoM 4 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com4raw.jpg');
saveas(figure2,'com4processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_5_raw(3:end),'b')
title('CoM 5 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_5_data,'g')
yline(com_5_mean,'k--','Mean')
title('CoM 5 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com5raw.jpg');
saveas(figure2,'com5processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_6_raw(3:end),'b')
title('CoM 6 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_6_data,'g')
yline(com_6_mean,'k--','Mean')
title('CoM 6 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com6raw.jpg');
saveas(figure2,'com6processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_7_raw(3:end),'b')
title('CoM 7 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_7_data,'g')
yline(com_7_mean,'k--','Mean')
title('CoM 7 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com7raw.jpg');
saveas(figure2,'com7processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_8_raw(3:end),'b')
title('CoM 8 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_8_data,'g')
yline(com_8_mean,'k--','Mean')
title('CoM 8 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com8raw.jpg');
saveas(figure2,'com8processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_9_raw(3:end),'b')
title('CoM 9 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_9_data,'g')
yline(com_9_mean,'k--','Mean')
title('CoM 9 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com9raw.jpg');
saveas(figure2,'com9processed.jpg');


%--------------------------------------
figure1 = figure
plot(com_10_raw(3:end),'b')
title('CoM 10 Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(com_10_data,'g')
yline(com_10_mean,'k--','Mean')
title('CoM 10 Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'com10raw.jpg');
saveas(figure2,'com10processed.jpg');


%--------------------------------------
figure1 = figure
plot(zero_raw(2:end),'b')
title('Zero Raw');
ylabel('Nm');
xlabel('No. of readings');

figure2 = figure
plot(zero_data,'g')
yline(zero_mean,'k--','Mean')
title('Zero Processed and Mean');
ylabel('Nm');
xlabel('No. of readings');

saveas(figure1,'zeroraw.jpg');
saveas(figure2,'zeroprocessed.jpg');


%--------------------------------------



%% Input the CoM torques and angles for each point, zero offset, and liquid mass

% Setting up initial variables

g = 9.81;
mc = 0.339; %kg
L = 0.260; %m
Lg = 0.160; %m
R = 0.03015; %m

% Water
%ml = 0.188; %kg

% Oil
ml = 0.169; %kg

% Setting up changing torques between points

zero = -0.005949557;

Tz1 = 0.016321445 - zero;
Tz2 = -0.048950251 - zero;
Tz3 = -0.094856618 - zero;
Tz4 = -0.166749024 - zero;
Tz5 = -0.21446498 - zero;
Tz6 = 0.378029927 - zero;
Tz7 = 0.414313405 - zero;
Tz8 = 0.453699982 - zero;
Tz9 = 0.483250221 - zero;
Tz10 = 0.509296794 - zero;

% Setting up changing angles between points

theta1 = 10.0001*pi/180;
theta2 = 19.714*pi/180;
theta3 = 29.7169*pi/180;
theta4 = 39.7129*pi/180;
theta5 = 49.714*pi/180;
theta6 = -10.2859*pi/180;
theta7 = -20.2861*pi/180;
theta8 = -30.2843*pi/180;
theta9 = -40.2869*pi/180;
theta10 = -50.2848*pi/180;


%CoM_1
fplot(@(h) (Tz1 - g*(mc*((L/2)-Lg)*sin(theta1) + ml*find_CoM(theta1,R,Lg,h,1))),[0 0.2]);
hold on

%CoM_2
fplot(@(h) (Tz2 - g*(mc*((L/2)-Lg)*sin(theta2) + ml*find_CoM(theta2,R,Lg,h,1))), [0 0.2]);

%CoM_3
fplot(@(h) (Tz3 - g*(mc*((L/2)-Lg)*sin(theta3) + ml*find_CoM(theta3,R,Lg,h,1))), [0 0.2]);

%CoM_4
fplot(@(h) (Tz4 - g*(mc*((L/2)-Lg)*sin(theta4) + ml*find_CoM(theta4,R,Lg,h,1))), [0 0.2]);

%CoM_5
fplot(@(h) (Tz5 - g*(mc*((L/2)-Lg)*sin(theta5) + ml*find_CoM(theta5,R,Lg,h,1))), [0 0.2]);


grid on
title('Comparison between the height of liquid and torque error across positive angular rotation');
xlabel('Liquid height (m)');
ylabel('Error between experimental and calculated torque (Nm)');

legend('CoM_1 @ 10.0001 degrees','CoM_2 @ 19.714 degrees','CoM_3 @ 29.7169 degrees','CoM_4 @ 39.7129 degrees','CoM_5 @ 49.714 degrees');

pause();

hold off;

%CoM_6
fplot(@(h) (Tz6 - g*(mc*((L/2)-Lg)*sin(theta6) + ml*find_CoM(theta6,R,Lg,h,1))), [0 0.2]);
hold on
 
%CoM_7
fplot(@(h) (Tz7 - g*(mc*((L/2)-Lg)*sin(theta7) + ml*find_CoM(theta7,R,Lg,h,1))), [0 0.2]);

%CoM_8
fplot(@(h) (Tz8 - g*(mc*((L/2)-Lg)*sin(theta8) + ml*find_CoM(theta8,R,Lg,h,1))), [0 0.2]);

%CoM_9
fplot(@(h) (Tz9 - g*(mc*((L/2)-Lg)*sin(theta9) + ml*find_CoM(theta9,R,Lg,h,1))), [0 0.2]);

%CoM_10
fplot(@(h) (Tz10 - g*(mc*((L/2)-Lg)*sin(theta10) + ml*find_CoM(theta10,R,Lg,h,1))), [0 0.2]);

grid on
title('Comparison between the height of liquid and torque error across negative angular rotation');
xlabel('Liquid height (m)');
ylabel('Error between experimental and calculated torque (Nm)');

legend('CoM_6 @ -10.2859 degrees','CoM_7 @ -20.2861 degrees','CoM_8 @ -30.2843 degrees','CoM_9 @ -40.2869 degrees','CoM_1_0 @ -50.2848 degrees');


%% Calculate the extimate for the volume at a particular angle and height value

h = 0.00;
theta = 0*pi/180;

V = ((pi*R^2)*((h/cos(theta)) - 2*R*tan(theta)) + (pi*R^3)*tan(theta))*10^6














