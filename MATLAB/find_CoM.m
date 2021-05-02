function[x_l] = find_CoM(theta,R,Lg,h,method)

switch method

    case 1
    % Bottom face covered, top face dry
    
    % Solving Volume
    V = (pi*R^2)*((h/cos(theta)) - 2*R*tan(theta)) + (pi*R^3)*tan(theta);
    
    % Solving x_B
    x_B = ((pi*R^4)/(4*V))*tan(theta);
    
    % Solving y_B
    a = (R*tan(theta)+(h/cos(theta))-(2*R*tan(theta)))^2;
    b = (0.5*pi*R^2);
    c = ((tan(theta).^2)*(0.125*pi*R^4));

    y_B = (1/V)*((a*b)+c);
    
    
    % Solving for the final x position of the CoM

    x_l = x_B*cos(theta) + y_B*sin(theta) - Lg*sin(theta);


    case 2
    % Bottom face partially covered, top face dry
    
    alpha = R - (h/sin(theta));
    beta = sqrt((R^2) - (alpha^2));
    
    a = ((2*beta^3)/3);
    b = (pi*R^2)/2;
    c = alpha*beta;
    d = (R^2)*atan(alpha/beta);
    
    
    % Solving Volume
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
    
    
    % Solving for the final x position of the CoM
    
    x_l = x_B*cos(theta) + y_B*sin(theta) - Lg*sin(theta);
    

    otherwise
        
    fprintf("Invalid method entered\n");
    
end

end