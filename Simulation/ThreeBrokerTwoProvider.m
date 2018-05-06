%%
% In this file 3 games with 3 brokers and 2 providers are simulated
% Qualities of Service providers are fixed in all the games
% Quality of B_1 and B_3 in each game is different, but it's fixed within a
% game.
% B_2 changes qauality in each game to simulate the market with different
% qualities 
% Qi, ri, Di & SUi are quality, price, demand and profit of S_i
% qi, Pi, di & BUi are quality, price, demand and profit of B_i
%%

clc
clear
cstring = '.*o';
mx = 70; %theta_max
mn = 1;  %theta_min
c = .2;

cnt1 = 1;
n = 3;
Q1 = 30;
Q2 = 60;
 k1 = .01265*Q1^1.5;
 k2 = .01265*Q2^1.5;
 q1s = [10,15,20]; % Qualities to check for B_1
 q3s = [90,80,70]; % Qualities to check for B_2

 cnt = 1;

 step = 2;
 for i =1:3
     cnt = 1;
     clear d1 d2 d3 d4 p1 p2 p3 p4 r1 r2 BU1 BU2 BU3 BU4 SU1 SU2 D1 D2
     q1 = q1s(i);
     q3 = q3s(i);
     q2l = q1+3; % lower bound for B_2
     q2h = q3-3; % upper bound for B_2
     for q2 = q2l:step:q2h 

    %      if q2/Q1*rp1+c*(q2-Q1)^2<q2/Q2*rp2+c*(q2-Q2)^2
         if abs(q2-Q1)<abs(q2-Q2) % if q2 is closer to Q1 then it picks Q1 
             % S_1 price
             r1(cnt)=(2*k1*Q2*(6*q1^3*(q2-q3)-2*q2*(q2-3*q3)*q3^2-2*q1*q3^2*(q2+3*q3)+q1^2*(3*q2^2-12*q2*q3+13*q3^2))+...
                Q1*(k2*q3*(q1^2*(6*q2-2*q3)-2*q2*(q2-3*q3)*q3+q1*(3*q2^2-14*q2*q3+3*q3^2))+...
                mn*Q2*(q2-q3)*(12*q1^3+7*q1^2*(3*q2-5*q3)-2*q2*(q2-6*q3)*q3+q1*(3*q2^2-35*q2*q3+24*q3^2))+...
                Q2*(c*(2*q3*(6*q3^2*((q1-Q1)^2-(q2-Q1)^2)+q2^2*((q1-Q1)^2-(q3-Q2)^2)+....2
                q2*q3*(-7*(q1-Q1)^2+4*(q2-Q1)^2+3*(q3-Q2)^2))+q1*(-3*q2^2*((q1-Q1)^2-(q3-Q2)^2)+...
                14*q2*q3*(2*(q1-Q1)^2-(q2-Q1)^2-(q3-Q2)^2)+q3^2*(-25*(q1-Q1)^2+22*(q2-Q1)^2+3*(q3-Q2)^2))-...
                2*q1^2*(q3*(-6*(q1-Q1)^2+5*(q2-Q1)^2+(q3-Q2)^2)+q2*(6*(q1-Q1)^2-3*((q2-Q1)^2+(q3-Q2)^2))))+...
                (q2-q3)*(2*q2*(q2-9*q3)*q3+8*q1^2*(-3*q2+q3)+q1*(-3*q2^2+44*q2*q3-9*q3^2))*mx)))/...
                (3*Q2*(8*q1^3*(q2-q3)-4*q2*(q2-2*q3)*q3^2+4*q1*q3*(q2^2-q2*q3-2*q3^2)+q1^2*(q2^2-14*q2*q3+17*q3^2)));
            % S_2 price
            r2(cnt) = (k1*Q2*(-4*q2^2*q3^3+2*q1*q2*q3^2*(3*q2+q3)+2*q1^2*q3*(3*q2^2-6*q2*q3+q3^2)-3*q1^3*(3*q2^2-4*q2*q3+q3^2))+...
                Q1*(2*k2*q3*(-6*q1^3*(q2-q3)+2*q2*(q2-3*q3)*q3^2+2*q1*q3^2*(q2+3*q3)+q1^2*(-3*q2^2+12*q2*q3-13*q3^2))-...
                mn*Q2*(q2-q3)*(3*q1^3*(5*q2-3*q3)+8*q2^2*q3^2+2*q1*q2*q3*(-6*q2+q3)+q1^2*(3*q2^2-15*q2*q3+8*q3^2))+...
                Q2*(-c*(12*q1^3*(q2-q3)*((q2-Q1)^2-(q3-Q2)^2)+4*q2*q3^2*(q3*(2*(q1-Q1)^2+(q2-Q1)^2-3*(q3-Q2)^2)-...
                2*q2*((q1-Q1)^2-(q3-Q2)^2))+q1^2*(q3^2*(3*(q1-Q1)^2+22*(q2-Q1)^2-25*(q3-Q2)^2)-...
                3*q2^2*((q1-Q1)^2-(q3-Q2)^2)-18*q2*q3*((q2-Q1)^2-(q3-Q2)^2))+...
                2*q1*q3*(-q3^2*((q1-Q1)^2+5*(q2-Q1)^2-6*(q3-Q2)^2)+6*q2^2*((q1-Q1)^2-(q3-Q2)^2)+...
                q2*q3*(-5*(q1-Q1)^2+(q2-Q1)^2+4*(q3-Q2)^2)))+(q2-q3)*(24*q1^3*(q2-q3)+...
                4*q2*q3^2*(2*q2+3*q3)-4*q1*q3*(3*q2^2+4*q2*q3+3*q3^2)+q1^2*(3*q2^2-18*q2*q3+35*q3^2))*mx)))/...
                (3*Q1*q3*(-8*q1^3*(q2-q3)+4*q2*(q2-2*q3)*q3^2+4*q1*q3*(-q2^2+q2*q3+2*q3^2)-q1^2*(q2^2-14*q2*q3+17*q3^2)));
            % In case if violating the constraint for S_1
            if q2/Q2*r2(cnt)+c*(q2-Q2)^2-(q2/Q1*r1(cnt)+c*(q2-Q1)^2)<0
                eps = 10;
                r1(cnt) =-eps+ 1/(q2*Q2*(3*q1*q2-5*q1*q3-4*q2*q3+6*q3^2))*Q1*(c*Q2*(-q2*(q1^2*q2+Q1^2*q2+2*q1*(Q1^2-3*Q1*q2+q2^2))+...
                    q2*(2*q1+q2)*Q2^2+(q1^2*q2+2*q1*(2*Q1^2-5*Q1*q2+2*(q2-Q2)*Q2)+q2*...
                    (5*Q1^2-8*Q1*q2+2*q2^2+2*q2*Q2-5*Q2^2))*q3+(-6*Q1^2+2*q1*q2+12*Q1*q2+...
                    q2^2-6*q2*Q2+6*Q2^2)*q3^2-3*q2*q3^3)+q2*(-mn*(q1-q2)*Q2*(q2-q3)-k2*(2*q1+q2-3*q3)*q3+Q2*(4*q1-q2-3*q3)*(q2-q3)*mx));


                r2(cnt) = 1/(2*Q1*(2*q1+q2-3*q3)*q3)*(mn*Q1*(q1-q2)*Q2*(q2-q3)+2*k2*q1*Q1*q3+k2*Q1*q2*q3-3*k2*Q1*q3^2+...
                    c*Q1*Q2*(q2*(Q1-Q2)*(Q1+Q2)+q1^2*(q2-q3)+(-3*Q1^2+4*Q1*q2-2*q2^2+2*q2*Q2+3*Q2^2)*...
                    q3-(q2+6*Q2)*q3^2+3*q3^3+2*q1*(Q1^2+Q1*(-3*q2+q3)+(q2+Q2-q3)*(q2-Q2+q3)))+...
                    3*q1*q2*Q2*r1(cnt)-q1*Q2*q3*r1(cnt)-2*q2*Q2*q3*r1(cnt)+Q1*Q2*(4*q1-q2-3*q3)*(-q2+q3)*mx);


            end
            pos1(cnt) = q1/Q1*r1(cnt)+c*(q1-Q1)^2-(q1/Q2*r2(cnt)+c*(q1-Q2)^2);
            pos2(cnt) = q3/Q2*r2(cnt)+c*(q3-Q2)^2-(q3/Q1*r1(cnt)+c*(q3-Q1)^2);

            % Price of B_1
            p1(cnt) = 1/(6*Q1*Q2*(q1-q3))*(mn*Q1*(q1-q2)*Q2*(3*q1+q2-4*q3)+3*q1^2*Q2*r1(cnt)-2*q2*Q2*q3*r1(cnt)-Q1*q2*q3*r2(cnt)+...
                c*Q1*q2*Q2*(q1-Q1)^2-4*c*Q1*Q2*q3*(q1-Q1)^2-2*c*Q1*Q2*q3*(q2-Q1)^2-c*Q1*q2*Q2*(q3-Q2)^2+...
                Q1*q2^2*Q2*mx-Q1*q2*Q2*q3*mx+q1*(Q1*q3*r2(cnt)+q2*Q2*(3*r1(cnt)-Q1*mx)+...
                Q2*(c*Q1*(3*(q1-Q1)^2+2*(q2-Q1)^2+(q3-Q2)^2)+q3*(-4*r1(cnt)+Q1*mx))));

            % Price of B_2
            p2(cnt) = -(1/(3*Q1*Q2*(q1-q3)))*(-mn*Q1*(q1-q2)*Q2*(q2-q3)+2*q2*Q2*q3*r1(cnt)+...
                Q1*q2*q3*r2(cnt)-c*Q1*q2*Q2*(q1-Q1)^2+c*Q1*Q2*q3*(q1-Q1)^2+2*c*Q1*Q2*q3*(q2-Q1)^2+...
                c*Q1*q2*Q2*(q3-Q2)^2-Q1*q2^2*Q2*mx+Q1*q2*Q2*q3*mx-q1*(Q1*q3*r2(cnt)+q2*Q2*(3*r1(cnt)-Q1*mx)+...
                Q2*(-q3*r1(cnt)+2*c*Q1*(q2-Q1)^2+c*Q1*(q3-Q2)^2+Q1*q3*mx)));
            % Price of B_3
            p3(cnt) = -(1/(6*Q1*Q2*(q1-q3)))*(-mn*Q1*(q1-q2)*Q2*(q2-q3)+2*q2*Q2*q3*r1(cnt)+...
                Q1*q2*q3*r2(cnt)+3*Q1*q3^2*r2(cnt)-c*Q1*q2*Q2*(q1-Q1)^2+c*Q1*Q2*q3*(q1-Q1)^2+...
                2*c*Q1*Q2*q3*(q2-Q1)^2+c*Q1*q2*Q2*(q3-Q2)^2+3*c*Q1*Q2*q3*(q3-Q2)^2-Q1*q2^2*Q2*mx-...
                2*Q1*q2*Q2*q3*mx+3*Q1*Q2*q3^2*mx-q1*(4*Q1*q3*r2(cnt)+q2*Q2*(3*r1(cnt)-4*Q1*mx)+...
                Q2*(-q3*r1(cnt)+2*c*Q1*(q2-Q1)^2+4*c*Q1*(q3-Q2)^2+4*Q1*q3*mx)));

            d1(cnt) = (((p2(cnt)-p1(cnt))/(q2-q1))-mn)/(mx-mn); % demand of B_1
            d2(cnt) = (((p3(cnt)-p2(cnt))/(q3-q2))-((p2(cnt)-p1(cnt))/(q2-q1)))/(mx-mn); % Demand of B_2
            d3(cnt) = (mx - ((p3(cnt)-p2(cnt))/(q3-q2)))/(mx-mn); % Demand of B_3
            D1(cnt) = d1(cnt)+d2(cnt); % Demand of S_1
            D2(cnt) = d3(cnt); % Demand of S_3
            BU1(cnt) = d1(cnt)*(p1(cnt)-(q1/Q1*r1(cnt)+c*(q1-Q1)^2)); % B_1 utility
            BU2(cnt) = d2(cnt)*(p2(cnt)-(q2/Q1*r1(cnt)+c*(q2-Q1)^2)); % B_2 utility
            BU3(cnt) = d3(cnt)*(p3(cnt)-(q3/Q2*r2(cnt)+c*(q3-Q2)^2)); % B_3 utility
            SU1(cnt) = (d1(cnt)*q1/Q1+d2(cnt)*q2/Q1)*(r1(cnt)-k1); % S_1 utility
            SU2(cnt) = (d3(cnt)*q3/Q2)*(r2(cnt)-k2); % S_1 utility


         else % if B_2 prefers to buy from S_2

             r1(cnt) = (k2*Q1*(9*q2^2*q3^3-6*q1*q2*q3^2*(q2+2*q3)+q1^3*(4*q2^2-2*q2*q3-2*q3^2)+3*q1^2*q3*(-2*q2^2+4*q2*q3+q3^2))+...
                Q2*(2*k1*q1*(6*q1^3*(q2-q3)-6*q1*q3^2*(2*q2+q3)+3*q2*q3^2*(q2+2*q3)+q1^2*(-2*q2^2-2*q2*q3+13*q3^2))+...
                Q1*(mn*(12*q1^4*(q2-q3)-3*q2^2*q3^2*(q2+8*q3)+3*q1*q2*q3*(4*q2^2+7*q2*q3+16*q3^2)+...
                q1^3*(-4*q2^2-4*q2*q3+35*q3^2)-q1^2*(8*q2^3-4*q2^2*q3+53*q2*q3^2+24*q3^3))+...
                c*(3*q2*q3^2*(4*q3*(-(q1-Q1)^2+(q2-Q2)^2)+q2*((q1-Q1)^2-(q3-Q2)^2))+6*q1*q3*(3*q2*q3*((q1-Q1)^2-(q2-Q2)^2)+...
                2*q3^2*((q1-Q1)^2-(q2-Q2)^2)-2*q2^2*((q1-Q1)^2-(q3-Q2)^2))-2*q1^3*(q2*(6*(q1-Q1)^2-2*(q2-Q2)^2-4*(q3-Q2)^2)+...
                q3*(-6*(q1-Q1)^2+5*(q2-Q2)^2+(q3-Q2)^2))+q1^2*(2*q2*q3*(4*(q1-Q1)^2+(q2-Q2)^2-5*(q3-Q2)^2)+...
                8*q2^2*((q1-Q1)^2-(q3-Q2)^2)+q3^2*(-25*(q1-Q1)^2+22*(q2-Q2)^2+3*(q3-Q2)^2)))+(3*q2^2*q3^2*(q2+5*q3)-...
                2*q1^3*(4*q2^2+q2*q3+4*q3^2)-6*q1*q2*q3*(2*q2^2+3*q2*q3+4*q3^2)+...
                q1^2*(8*q2^3+14*q2^2*q3+23*q2*q3^2+9*q3^3))*mx)))/...
                (3*q1*Q2*(8*q1^3*(q2-q3)+q2*q3^2*(q2+8*q3)-2*q1*q3*(-2*q2^2+7*q2*q3+4*q3^2)+q1^2*(-4*q2^2-4*q2*q3+17*q3^2)));

            r2(cnt) = (2*k2*Q1*(6*q1^3*(q2-q3)-6*q1*q3^2*(2*q2+q3)+3*q2*q3^2*(q2+2*q3)+q1^2*(-2*q2^2-2*q2*q3+13*q3^2))+...
                Q2*(k1*q1*(3*q1^2*(2*q2+q3)+3*q2*q3*(q2+2*q3)-2*q1*(q2^2+7*q2*q3+q3^2))+Q1*(mn*(q1-q2)*(9*q1^2*(2*q2+q3)+...
                3*q2*q3*(q2+8*q3)-2*q1*(q2^2+22*q2*q3+4*q3^2))+c*(-12*q1^3*((q2-Q2)^2-(q3-Q2)^2)+...
                q1^2*(q3*(3*(q1-Q1)^2+22*(q2-Q2)^2-25*(q3-Q2)^2)+2*q2*(3*(q1-Q1)^2+4*(q2-Q2)^2-7*(q3-Q2)^2))+...
                3*q2*q3*(2*q3*((q1-Q1)^2+(q2-Q2)^2-2*(q3-Q2)^2)+q2*((q1-Q1)^2-(q3-Q2)^2))-...
                2*q1*(q3^2*((q1-Q1)^2+5*(q2-Q2)^2-6*(q3-Q2)^2)+7*q2*q3*((q1-Q1)^2+(q2-Q2)^2-2*(q3-Q2)^2)+q2^2*((q1-Q1)^2-(q3-Q2)^2)))+...
                (-12*q1^3*(q2+2*q3)+3*q2*q3*(q2^2+7*q2*q3+4*q3^2)+q1^2*(14*q2^2+59*q2*q3+35*q3^2)-...
                2*q1*(q2^3+19*q2^2*q3+28*q2*q3^2+6*q3^3))*mx)))/...
                (3*Q1*(8*q1^3*(q2-q3)+q2*q3^2*(q2+8*q3)-2*q1*q3*(-2*q2^2+7*q2*q3+4*q3^2)+q1^2*(-4*q2^2-4*q2*q3+17*q3^2)));

            if (q2/Q1*r1(cnt)+c*(q2-Q1)^2)-(q2/Q2*r2(cnt)+c*(q2-Q2)^2)<0 % Violating the constraint by S_2
                eps = -10;
                r2(cnt) =eps+ 1/(Q1*q2*(-6*q1^2+4*q1*q2+5*q1*q3-3*q2*q3))*Q2*(c*Q1*(3*q1^3*q2-q1^2*...
                    (6*Q1^2-6*Q1*q2+q2^2-6*Q2^2+2*q2*(6*Q2+q3))+q2*(q2*Q2^2+2*(q2^2-3*q2*Q2+Q2^2)*q3+...
                    q2*q3^2-Q1^2*(q2+2*q3))+q1*(-2*q2^3+8*q2^2*Q2-4*Q2^2*q3-2*Q1*q2*(q2+2*q3)+...
                    Q1^2*(5*q2+4*q3)-q2*(5*Q2^2-10*Q2*q3+q3^2)))+q2*(k1*q1*(-3*q1+q2+2*q3)-Q1*(q1-q2)*(mn*(3*q1+q2-4*q3)+(-q2+q3)*mx)));
                r1(cnt) = 1/(2*q1*Q2*(3*q1-q2-2*q3))*(k1*q1*Q2*(3*q1-q2-2*q3)+Q1*(mn*(q1-q2)*...
                    Q2*(3*q1+q2-4*q3)+c*Q2*(-3*q1^3-q2*Q2^2-2*(q2^2-3*q2*Q2+Q2^2)*q3-q2*q3^2+Q1^2*(q2+2*q3)+...
                    q1^2*(6*Q1+q2+2*q3)+q1*(-3*Q1^2+2*q2^2-4*q2*Q2+3*Q2^2-2*Q2*q3+...
                    q3^2-2*Q1*(q2+2*q3)))+(-3*q2*q3+q1*(2*q2+q3))*r2(cnt)-(q1-q2)*Q2*(q2-q3)*mx));


            end
            if (q1/Q2*r2(cnt)+c*(q1-Q2)^2)-(q1/Q1*r1(cnt)+c*(q1-Q1)^2)<0 % Violating the constraint by S_1
                eps = -10;

                r1(cnt) =eps+ (1/(q1*Q2*(q1^2*(2*q2-5*q3)-6*q2*q3^2+3*q1*q3*(q2+2*q3))))*Q1*...
                    (k2*q1*(2*q1^2*(q2-q3)+3*q1*q3^2-3*q2*q3^2)+Q2*(c*(2*q1^2*q2*(q1^2-Q1^2+...
                    q1*(2*Q1-q2-2*Q2)+Q2^2)+q1*(q1^3+q1^2*(-10*Q1-3*q2+4*Q2)+q1*(5*Q1^2+6*Q1*q2+2*q2^2-5*Q2^2)+...
                    3*q2*(-Q1^2+Q2^2))*q3+2*(q1-q2)*(q1^2+6*q1*Q1-3*Q1^2-3*q1*Q2+3*Q2^2)*q3^2+...
                    3*q1*(-q1+q2)*q3^3)+mn*q1*(q1-q2)*(-3*q2*q3+q1*(2*q2+q3))-q1*(q1-q2)*(-3*q3*(q2+q3)+2*q1*(q2+2*q3))*mx));

                r2(cnt) = (1/(4*q1^2*Q1*(q2-q3)+6*q1*Q1*q3^2-6*Q1*q2*q3^2))*(k2*Q1*(2*q1^2*(q2-q3)+...
                    3*q1*q3^2-3*q2*q3^2)+Q2*(mn*Q1*(q1-q2)*(-3*q2*q3+q1*(2*q2+q3))-3*Q1*q2*q3*...
                    (c*(q1-Q1+Q2-q3)*(q1-Q1-Q2+q3)+(q2+q3)*mx)+q1^2*(-2*c*Q1*(q2-q3)*(q2-2*Q2+q3)+...
                    (2*q2+q3)*r1(cnt)-2*Q1*(q2+2*q3)*mx)+q1*(2*Q1*q2^2*mx+Q1*q3*(c*((q1-Q1)^2+2*(q2-Q2)^2-3*...
                    (Q2-q3)^2)+3*q3*mx)+q2*(2*c*Q1*(-q1+Q1+Q2-q3)*(-q1+Q1-Q2+q3)-3*q3*r1(cnt)+7*Q1*q3*mx))));
            end


            pos1(cnt) = q1/Q1*r1(cnt)+c*(q1-Q1)^2-(q1/Q2*r2(cnt)+c*(q1-Q2)^2);
            pos2(cnt) = q3/Q2*r2(cnt)+c*(q3-Q2)^2-(q3/Q1*r1(cnt)+c*(q3-Q1)^2);


            p1(cnt) = 1/(6*Q1*Q2*(q1-q3))*(mn*Q1*(q1-q2)*Q2*(3*q1+q2-4*q3)+3*q1^2*Q2*r1(cnt)+q1*(Q1*q3*r2(cnt)+q2*(2*Q1*r2(cnt)+Q2*(r1(cnt)-Q1*mx))+...
                Q2*(c*Q1*(3*(q1-Q1)^2+2*(q2-Q2)^2+(q3-Q2)^2)+q3*(-4*r1(cnt)+Q1*mx)))+...
                Q1*(-2*c*Q2*q3*(2*(q1-Q1)^2+(q2-Q2)^2)+q2^2*Q2*mx-q2*(c*Q2*(-(q1-Q1)^2+(q3-Q2)^2)+q3*(3*r2(cnt)+Q2*mx))));

            p2(cnt) = 1/(3*Q1*Q2*(q1-q3))*(mn*Q1*(q1-q2)*Q2*(q2-q3)+q1*(Q1*q3*r2(cnt)+Q2*(-q3*r1(cnt)+2*c*Q1*(q2-Q2)^2+c*Q1*(q3-Q2)^2+Q1*q3*mx)+...
                q2*(2*Q1*r2(cnt)+Q2*(r1(cnt)-Q1*mx)))+Q1*(-c*Q2*q3*((q1-Q1)^2+2*(q2-Q2)^2)+...
                q2^2*Q2*mx-q2*(c*Q2*(-(q1-Q1)^2+(q3-Q2)^2)+q3*(3*r2(cnt)+Q2*mx))));

            p3(cnt) = 1/(6*Q1*Q2*(q1-q3))*(mn*Q1*(q1-q2)*Q2*(q2-q3)+q1*(4*Q1*q3*r2(cnt)+...
                Q2*(-q3*r1(cnt)+2*c*Q1*(q2-Q2)^2+4*c*Q1*(q3-Q2)^2+4*Q1*q3*mx)+q2*(2*Q1*r2(cnt)+Q2*(r1(cnt)-4*Q1*mx)))+...
                Q1*(q2^2*Q2*mx-q3*(c*Q2*((q1-Q1)^2+2*(q2-Q2)^2+3*(q3-Q2)^2)+...
                3*q3*(r2(cnt)+Q2*mx))+q2*(c*Q2*((q1-Q1)^2-(q3-Q2)^2)+q3*(-3*r2(cnt)+2*Q2*mx))));

            d1(cnt) = (((p2(cnt)-p1(cnt))/(q2-q1))-mn)/(mx-mn);
            d2(cnt) = (((p3(cnt)-p2(cnt))/(q3-q2))-((p2(cnt)-p1(cnt))/(q2-q1)))/(mx-mn);
            d3(cnt) = (mx - ((p3(cnt)-p2(cnt))/(q3-q2)))/(mx-mn);
            D1(cnt) = d1(cnt);
            D2(cnt) = d3(cnt)+d2(cnt);
            BU1(cnt) = d1(cnt)*(p1(cnt)-(q1/Q1*r1(cnt)+c*(q1-Q1)^2));
            BU2(cnt) = d2(cnt)*(p2(cnt)-(q2/Q2*r2(cnt)+c*(q2-Q2)^2));
            BU3(cnt) = d3(cnt)*(p3(cnt)-(q3/Q2*r2(cnt)+c*(q3-Q2)^2));
            SU1(cnt) = (d1(cnt)*q1/Q1)*(r1(cnt)-k1);
            SU2(cnt) = (d2(cnt)*q2/Q2+d3(cnt)*q3/Q2)*(r2(cnt)-k2);




         end
        cnt = cnt+1; 
     end

     figure(1)
     subplot(1,3,i)
     p1p(n)= plot(q2l:step:q2h,r1,'-b','LineWidth',3);
     hold on
     p2p(n)=plot(q2l:step:q2h,r2,':r','Marker', cstring(1),'MarkerSize',10,'LineWidth',2);
     legend('S_1','S_2');
     xlabel('Quality of service offered by B_2');
     titPP = sprintf(' Providers Price, q_1 =  %d, q_3 = %d  ', q1, q3);
     title(titPP,'FontName','Times','fontsize',22,'fontweight','b');

     set(gca,'FontName','Times','fontsize',22,'fontweight','b') ;
     figure(2)
     subplot(1,3,i)
     p1d(n) = plot(q2l:step:q2h,D1,'b','LineWidth',3);
     hold on
     p2d(n) = plot(q2l:step:q2h,D2,':r','Marker', cstring(1),'MarkerSize',10,'LineWidth',2);
     legend('S_1','S_2');
     xlabel('Quality of service offered by B_2');
     titPD = sprintf('Provers Demand, q_1 =  %d, q_3 = %d  ', q1, q3);
     title(titPD,'FontName','Times','fontsize',22,'fontweight','b');
     set(gca,'FontName','Times','fontsize',22,'fontweight','b') ;

     figure(3)
     subplot(1,3,i)
     p1u(n) = plot(q2l:step:q2h,SU1,'-b','LineWidth',3);
     hold on
     p2u(n) = plot(q2l:step:q2h,SU2,':r','Marker', cstring(1),'MarkerSize',10,'LineWidth',2);
     legend('S_1','S_2')
     xlabel('Quality of service offered by B_2');
     titPU = sprintf('Providers Utility, q_1 =  %d, q_3 = %d  ', q1, q3);
     title(titPU,'FontName','Times','fontsize',22,'fontweight','b');
     set(gca,'FontName','Times','fontsize',22,'fontweight','b') ;
     
     figure(4)
     subplot(1,3,i)
     b1p(n) = plot(q2l:step:q2h,p1,'b','LineWidth',3);
     hold on
     b2p(n) = plot(q2l:step:q2h,p2,':r','Marker', cstring(1),'MarkerSize',10,'LineWidth',2);
     hold on
     b3p(n) = plot(q2l:step:q2h,p3,'-.k','LineWidth',3);
     legend('B_1','B_2','B_3');
     xlabel('Quality of service offered by B_2');
     titBP = sprintf('Brokers price, q_1 =  %d, q_3 = %d  ', q1, q3);
     title(titBP,'FontName','Times','fontsize',22,'fontweight','b');
     set(gca,'FontName','Times','fontsize',20,'fontweight','b');

     
    figure(5)
     subplot(1,3,i)
     b1d(n)= plot(q2l:step:q2h,d1,'-b','LineWidth',3);
     hold on
     b2d(n) = plot(q2l:step:q2h,d2,':r','Marker', cstring(1),'MarkerSize',10,'LineWidth',2);
     hold on
     b3d(n) = plot(q2l:step:q2h,d3,'-.k','LineWidth',3);
     titBD = sprintf('Brokers Demand, q_1 =  %d, q_3 = %d  ', q1, q3);
     legend('B_1','B_2','B_3');
     xlabel('Quality of service offered by B_2');
     title(titBD,'FontName','Times','fontsize',22,'fontweight','b');
     set(gca,'FontName','Times','fontsize',22,'fontweight','b') ;


     figure(6)
     subplot(1,3,i)
     b1u(n) = plot(q2l:step:q2h,BU1,'-b','LineWidth',3);
     hold on
     b2u(n) = plot(q2l:step:q2h,BU2,':r','Marker', cstring(1),'MarkerSize',10,'LineWidth',2);
     hold on
     b3u(n) = plot(q2l:step:q2h,BU3,'-.k','LineWidth',3);
     legend('B_1','B_2','B_3');
     xlabel('Quality of service offered by B_2');
     titBU = sprintf('Brokers Utility, q_1 =  %d, q_3 = %d  ', q1, q3);
     title(titBU,'FontName','Times','fontsize',20,'fontweight','b');
     set(gca,'FontName','Times','fontsize',20,'fontweight','b');

     
     
 end
 
 

 
