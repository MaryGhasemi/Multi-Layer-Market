%%
% In this file games with 2 brokers and 2 providers are simulated
% Qualities of Service providers are fixed in all the games
% Quality of B_2 changes between  q2L & q2H 
% Quality of B_1 is a fixed value that's been assigned to it in each game

% Qi, ri, Di & Ui are quality, price, demand and profit of S_i
% qi, Pi, di & Bi are quality, price, demand and profit of B_i
%%
clear
mx = 1.5; % theta_max
mn = 0.2; % theta_min
c = .16;  
Q1 = 20;  
Q2 = 45;
cnt1 = 1;
%i = 1;
q2L = 30; %B_2 lower bound quality
q2H = 60; % B_2 upper bound quality
cstring='brkmcgyo'; 
n = 0;
AA = [13,17,20,23,29]; % qualities for B_1


for q1 = AA 
    for q2 = q2L:1:q2H
       k2 = .01265*Q2^1.5; % Cost of providing quality Q_2
       k1 = .01265*Q1^1.5; % Cost of providing quality Q_1
       % S_1 price
       r1(cnt1) = (k2*q2*Q1+2*k1*q1*Q2)/(3*q1*Q2)+ Q1*(-c*(q1-Q1)^2+c*(q2-Q2)^2-(q1-q2)*(4*mx-5*mn))/(3*q1);
       %S_2 price
       r2(cnt1) = (2*k2*q2*Q1+k1*q1*Q2)/(3*q2*Q1)+ Q2*(c*(q1-Q1)^2-c*(q2-Q2)^2-(q1-q2)*(5*mx-4*mn))/(3*q2);
       %Checking the positive constraint for S_1
       pos1 = q1*r1(cnt1)/Q1+c*(Q1-q1)^2-q1*r2(cnt1)/Q2-c*(q1-Q2)^2; 
       %Checking the positive constraint for S_2
       pos2 = q2*r2(cnt1)/Q2+c*(Q2-q2)^2-q2*r1(cnt1)/Q1-c*(q2-Q1)^2; 
       % S_1 demand
       D1(cnt1) = (1/(mx-mn))*((c*(q2-Q2)^2-c*(q1-Q1)^2-q1*r1(cnt1)/Q1+q2*r2(cnt1)/Q2)/(3*(q2-q1))+(mx-2*mn)/3);
       % S_2 demand
       D2(cnt1) = (1/(mx-mn))*((c*(q1-Q1)^2-c*(q2-Q2)^2+q1*r1(cnt1)/Q1-q2*r2(cnt1)/Q2)/(3*(q2-q1))+(2*mx-mn)/3);
       % B_1 price
       p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q2)^2+2*q1*r1(cnt1)/Q1+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
       % B_2 price
       p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q2)^2+q1*r1(cnt1)/Q1+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
       %B_1 demand
       d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
       %B_2 demand
       d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
       rr1 = (q1*k2/Q2+c*(q1-Q2)^2-c*(q1-Q1)^2)*(Q1/q1); % Price of S_1 if constraint is violated
       rr2 = (q1*k1/Q1+c*(q1-Q1)^2-c*(q1-Q2)^2)*(Q2/q1); % Price of S_2 if constraint is violated
       U1(cnt1) = D1(cnt1)*q1/Q1*(r1(cnt1)-k1); % S_1 Utility
       U2(cnt1) = D2(cnt1)*q2/Q2*(r2(cnt1)-k2); % S_2 Utility
       B1(cnt1) = p1(cnt1)*d1(cnt1)-d1(cnt1)*(q1*r1(cnt1)/Q1+c*(q1-Q1)^2); % B_1 Utility
       B2(cnt1) = p2(cnt1)*d2(cnt1)-d2(cnt1)*(q2*r2(cnt1)/Q2+c*(q2-Q2)^2); % B_2 Utility
       if q1>=q2
           D1(cnt1) = NaN;
           D2(cnt1) = NaN;
           p1(cnt1) = NaN;
           p2(cnt1) = NaN;
           d1(cnt1) = NaN;
           d2(cnt1) = NaN;
           r1(cnt1) = NaN;
           r2(cnt1) = NaN;
           U1(cnt1) = NaN;
           U2(cnt1) = NaN;
           B1(cnt1) = NaN;
           B2(cnt1) = NaN;
       elseif rr1<k1 % Checking the price to be more than the cost, otherwise broker is out of market 
           r1(cnt1) = 0;
           r2(cnt1) = (q1*k1/Q1+c*(q1-Q1)^2-c*(q1-Q2)^2)*(Q2/q1);
           D1(cnt1) = 0;
           D2(cnt1) = 1;
           p1(cnt1) = (2*c*(q1-Q2)^2+c*(q2-Q2)^2+2*q1*r2(cnt1)/Q2+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
           p2(cnt1) = (c*(q1-Q2)^2+2*c*(q2-Q2)^2+q1*r2(cnt1)/Q2+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
           d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
           d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
           U1(cnt1) = D1(cnt1)*q1/Q1*(r1(cnt1)-k1);
           U2(cnt1) = D2(cnt1)*q2/Q2*(r2(cnt1)-k2);
           B1(cnt1) = p1(cnt1)*d1(cnt1)-d1(cnt1)*(q1*r2(cnt1)/Q2+c*(q1-Q2)^2);
           B2(cnt1) = p2(cnt1)*d2(cnt1)-d2(cnt1)*(q2*r2(cnt1)/Q2+c*(q2-Q2)^2);

       elseif (pos1>0) % if S_1 price violates the constraint, it should redefine the price and S_2 consequantly 
           
           eps = (k2*q2*(-3*q1+2*q2)*Q1+Q2*(-k1*q1*(q1-2*q2)+Q1*(-c*q1^3+2*q2*(c*q2^2+c*(Q1^2-Q2^2)+q2*(-2*c*Q2+4*mx-5*mn))+...
            q1^2*(-2*c*q2+2*c*Q1+8*mx-7*mn)+q1*(c*q2^2+c*(Q2^2-Q1^2)+q2*(-4*c*c*Q1+6*c*Q2-16*mx+17*mn)))))/(2*q1*(q1-2*q2)*Q2); 
           if eps<0
               eps = .5;
           end

           r1(cnt1) = Q1*(k2*q1*q2+Q2*(c*q1^3+2*c*q2*(Q2^2-Q1^2)+q1^2*(-2*c*Q1-2*mx+mn)-q1*(c*q2^2+c*(Q2^2-Q1^2)...
                +q2*(-4*c*Q1+2*c*Q2-2*mx+mn))))/(q1*Q2*(2*q2-q1))-eps;
            r2(cnt1) = (k2*q2*Q1+Q2*(c*q1^2*Q1+Q1*(-c*q2^2+c*(Q1^2-Q2^2)+q2*(2*c*Q2+2*mx-mn))+q1*(-2*c*Q1^2+r1(cnt1)+Q1*(-2*mx+mn))))/(2*q2*Q1);
           if r1(cnt1) < 0 || d1(cnt1)<0 || r1(cnt1)<k1 % if price or demand of S_1 forced to be negative or less than the cost
               if k1<(q1*k2/Q2+c*(q1-Q2)^2-c*(q1-Q1)^2)*(Q1/q1)
               % if the cost for S_1 is less than the min price that S_1 can pick if S_2 sets the price equal to 
               %its cost then it means that S_2 is out of market and price
               %of S_1 is calculated so that for S_2 the only price to
               %be able to stay in the market is its cost
                   r1(cnt1) = (q1*k2/Q2+c*(q1-Q2)^2-c*(q1-Q1)^2)*(Q1/q1);
                   r2(cnt1) = 0;
                   D1(cnt1) = 1;
                   D2(cnt1) = 0;
                   p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q1)^2+2*q1*r1(cnt1)/Q1+q2*r1(cnt1)/Q1+(q2-q1)*(mx-2*mn))/3;
                   p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q1)^2+q1*r1(cnt1)/Q1+2*q2*r1(cnt1)/Q1+(q2-q1)*(2*mx-mn))/3;
                   d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
                   d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
               else
                   % Same situation for S_2
                   r2(cnt1) =  (q1*k1/Q1+c*(q1-Q1)^2-c*(q1-Q2)^2)*(Q2/q1);
                   r1(cnt1) = 0;
                   D1(cnt1) = 0;
                   D2(cnt1) = 1;
                   p1(cnt1) = (2*c*(q1-Q2)^2+c*(q2-Q2)^2+2*q1*r2(cnt1)/Q2+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
                   p2(cnt1) = (c*(q1-Q2)^2+2*c*(q2-Q2)^2+q1*r2(cnt1)/Q2+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
                   d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
                   d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
               end % if k1<(q1*k2/Q2+c*(q1-Q2)^2-c*(q1-Q1)^2)*(Q1/q1) 
           else
               r2(cnt1) = (k2*q2*Q1+Q2*(c*q1^2*Q1+Q1*(-c*q2^2+c*(Q1^2-Q2^2)+q2*(2*c*Q2+2*mx-mn))+q1*(-2*c*Q1^2+r1(cnt1)+Q1*(-2*mx+mn))))/(2*q2*Q1);
               D1(cnt1) = (1/(mx-mn))*((c*(q2-Q2)^2-c*(q1-Q1)^2-q1*r1(cnt1)/Q1+q2*r2(cnt1)/Q2)/(3*(q2-q1))+(mx-2*mn)/3);
               D2(cnt1) = (1/(mx-mn))*((c*(q1-Q1)^2-c*(q2-Q2)^2+q1*r1(cnt1)/Q1-q2*r2(cnt1)/Q2)/(3*(q2-q1))+(2*mx-mn)/3);
               p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q2)^2+2*q1*r1(cnt1)/Q1+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
               p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q2)^2+q1*r1(cnt1)/Q1+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
               d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
               d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
           end  %if r1(cnt1) < 0 || d1(cnt1)<0 || r1(cnt1)<k1

      elseif r2(cnt1)<0   % in the main game not in the constraint game
          if (q1*k1/Q1+c*(q1-Q1)^2-c*(q1-Q2)^2)*(Q2/q1)<k2 % Chacking of cost vs min price for S_1 that can make S_2 out of market
               r2(cnt1) = 0;
               r1(cnt1) = (q1*k2/Q2+c*(q1-Q2)^2-c*(q1-Q1)^2)*(Q1/q1);
               D1(cnt1) = 1;
               D2(cnt1) = 0;
               p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q1)^2+2*q1*r1(cnt1)/Q1+q2*r1(cnt1)/Q1+(q2-q1)*(mx-2*mn))/3;
               p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q1)^2+q1*r1(cnt1)/Q1+2*q2*r1(cnt1)/Q1+(q2-q1)*(2*mx-mn))/3;
               d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
               d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
          else
               r2(cnt1) =  (q2*k1/Q1+c*(q2-Q1)^2-c*(q2-Q2)^2)*(Q2/q2);
               r1(cnt1) = 0;
               D1(cnt1) = 0;
               D2(cnt1) = 1;
               p1(cnt1) = (2*c*(q1-Q2)^2+c*(q2-Q2)^2+2*q1*r2(cnt1)/Q2+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
               p2(cnt1) = (c*(q1-Q2)^2+2*c*(q2-Q2)^2+q1*r2(cnt1)/Q2+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
               d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
               d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
               
          end
          
           
       elseif pos2 > 0 % Checking the cosntraint for S_2

           eps = 0.5;
           r2(cnt1) = (c*(q2-Q1)^2-c*(q2-Q2)^2+ (k1*q2/(2*Q1))+(q2*(-c*q1^2+c*q2^2+c*(Q2^2-Q1^2)+q2*(-2*c*Q2+mx-2*mn)+...
               q1*(2*c*Q1-mx+2*mn))/(2*q1)))/((q2/Q2)-(q2^2/(2*q1*Q2)))-eps;
           r1(cnt1) = (k1*q1*Q2+Q1*(-c*q1^2*Q2+c*q2^2*Q2+c*Q2*(Q2^2-Q1^2)+q2*(-2*c*Q2^2+r2(cnt1)+Q2*(mx-2*mn))))/(2*q1*Q2)+Q1*(2*c*Q1-mx+2*mn)/2;
           if r1(cnt1)<0 % if price of S_1 is negative there is no way to stay in the market
               r2(cnt1) =  (q2*k1/Q1+c*(q2-Q1)^2-c*(q2-Q2)^2)*(Q2/q2);
               r1(cnt1) = 0;
               D1(cnt1) = 0;
               D2(cnt1) = 1;
               p1(cnt1) = (2*c*(q1-Q2)^2+c*(q2-Q2)^2+2*q1*r2(cnt1)/Q2+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
               p2(cnt1) = (c*(q1-Q2)^2+2*c*(q2-Q2)^2+q1*r2(cnt1)/Q2+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
               d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
               d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));

           else % if none of above if happens it means that the prices in the equilibrium not violating any rules and demands and profit can be
               %calculated based on  that
               D1(cnt1) = (1/(mx-mn))*((c*(q2-Q2)^2-c*(q1-Q1)^2-q1*r1(cnt1)/Q1+q2*r2(cnt1)/Q2)/(3*(q2-q1))+(mx-2*mn)/3);
               D2(cnt1) = (1/(mx-mn))*((c*(q1-Q1)^2-c*(q2-Q2)^2+q1*r1(cnt1)/Q1-q2*r2(cnt1)/Q2)/(3*(q2-q1))+(2*mx-mn)/3);
               p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q2)^2+2*q1*r1(cnt1)/Q1+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
               p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q2)^2+q1*r1(cnt1)/Q1+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
               d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
               d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
           end
           if (d2(cnt1) < 0 ||r2(cnt1)<0 || r2(cnt1)<k2 ) % if price  of S_2 is negative in equilibrium or less than cost
               if (q2*k1/Q1+c*(q2-Q1)^2-c*(q2-Q2)^2)*(Q2/q2) > k2 % if S_2 can set the price to a value that forces S_1 to leave and makes profit as well 
                   r2(cnt1) =  (q2*k1/Q1+c*(q2-Q1)^2-c*(q2-Q2)^2)*(Q2/q2);
                   r1(cnt1) = 0;
                   D1(cnt1) = 0;
                   D2(cnt1) = 1;
                   p1(cnt1) = (2*c*(q1-Q2)^2+c*(q2-Q2)^2+2*q1*r2(cnt1)/Q2+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
                   p2(cnt1) = (c*(q1-Q2)^2+2*c*(q2-Q2)^2+q1*r2(cnt1)/Q2+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
                   d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
                   d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
               else % otherwise S_2 is out of game
                   r1(cnt1) = (q2*k2/Q2+c*(q2-Q2)^2-c*(q2-Q1)^2)*(Q1/q2);
                   r2(cnt1) = 0;
                   D1(cnt1) = 1;
                   D2(cnt1) = 0;
                   p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q1)^2+2*q1*r1(cnt1)/Q1+q2*r1(cnt1)/Q1+(q2-q1)*(mx-2*mn))/3;
                   p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q1)^2+q1*r1(cnt1)/Q1+2*q2*r1(cnt1)/Q1+(q2-q1)*(2*mx-mn))/3;
                   d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
                   d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
                   
               end
           end
           
           
       end
       if D2(cnt1)<0 % if the demand of S_2 is negative it means that it's out of market and whole market goes to S_1 
          r1(cnt1) = (k2*q2*Q1+2*k1*q1*Q2)/(3*q1*Q2)+ Q1*(-c*(q1-Q1)^2+c*(q2-Q2)^2-(q1-q2)*(4*mx-5*mn))/(3*q1);
          r2(cnt1) = 0;
          D1(cnt1) = 1;
          D2(cnt1) = 0;
          p1(cnt1) = (2*c*(q1-Q1)^2+c*(q2-Q1)^2+2*q1*r1(cnt1)/Q1+q2*r1(cnt1)/Q1+(q2-q1)*(mx-2*mn))/3;
          p2(cnt1) = (c*(q1-Q1)^2+2*c*(q2-Q1)^2+q1*r1(cnt1)/Q1+2*q2*r1(cnt1)/Q1+(q2-q1)*(2*mx-mn))/3;
          d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
          d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
          
       end
       
       if D1(cnt1)<0 % if the demand of S_1 is negative it means that it's out of market and whole market goes to S_2 
           r1(cnt1) = 0;
           r2(cnt1) = (2*k2*q2*Q1+k1*q1*Q2)/(3*q2*Q1)+ Q2*(c*(q1-Q1)^2-c*(q2-Q2)^2-(q1-q2)*(5*mx-4*mn))/(3*q2);
           D1(cnt1) = 0;
           D2(cnt1) = 1;
           p1(cnt1) = (2*c*(q1-Q2)^2+c*(q2-Q2)^2+2*q1*r2(cnt1)/Q2+q2*r2(cnt1)/Q2+(q2-q1)*(mx-2*mn))/3;
           p2(cnt1) = (c*(q1-Q2)^2+2*c*(q2-Q2)^2+q1*r2(cnt1)/Q2+2*q2*r2(cnt1)/Q2+(q2-q1)*(2*mx-mn))/3;
           d1(cnt1) = (1/(mx-mn))*(((p2(cnt1)-p1(cnt1))/(q2-q1))-mn);
           d2(cnt1) = (1/(mx-mn))*(mx-((p2(cnt1)-p1(cnt1))/(q2-q1)));
       end
       
       if d1(cnt1)<0 % if demand of B_1 is negative it means that B_1 is out of market and consequently S_1 or S_2 is out of market 
                       % depending on who is selling to the other broker
           d1(cnt1) = 0;
           d2(cnt1) = 1;
           p1(cnt1) = 0;
           if D1(cnt1) == 0
               p2(cnt1) = (q2-q1)*mn+q1*r2(cnt1)/Q2+c*(q1-Q2)^2; 
           else
               p2(cnt1) = (q2-q1)*mn+q1*r1(cnt1)/Q1+c*(q1-Q1)^2; 
           end
       end
       if d2(cnt1)<0 
           d2(cnt1) = 0;
           d1(cnt1) = 1;
           p2(cnt1) = 0;
           if D1(cnt1) == 0
               p1(cnt1) =r2(cnt1)*q2/Q2+c*(q2-Q2)^2-(q2-q1)*mx;
           else
               p1(cnt1) =r1(cnt1)*q2/Q1+c*(q2-Q1)^2-(q2-q1)*mx;
           end
       end
       
       U1(cnt1) = D1(cnt1)*q1/Q1*(r1(cnt1)-k1);
       U2(cnt1) = D2(cnt1)*q2/Q2*(r2(cnt1)-k2);
       B1(cnt1) = p1(cnt1)*d1(cnt1)-d1(cnt1)*(q1*r1(cnt1)/Q1+c*(q1-Q1)^2);
       B2(cnt1) = p2(cnt1)*d2(cnt1)-d2(cnt1)*(q2*r2(cnt1)/Q2+c*(q2-Q2)^2);
       if D1(cnt1) == 0
           U1(cnt1) = 0;
           U2(cnt1) = (d2(cnt1)*q2/Q2+d1(cnt1)*q1/Q2)*(r2(cnt1)-k2);
           B1(cnt1) = p1(cnt1)*d1(cnt1)-d1(cnt1)*(q1*r2(cnt1)/Q2+c*(q1-Q2)^2);
           B2(cnt1) = p2(cnt1)*d2(cnt1)-d2(cnt1)*(q2*r2(cnt1)/Q2+c*(q2-Q2)^2); 

       elseif D2(cnt1) == 0
           U2(cnt1) = 0;
           U1(cnt1) = (d2(cnt1)*q2/Q1+d1(cnt1)*q1/Q1)*(r1(cnt1)-k1);
           B1(cnt1) = p1(cnt1)*d1(cnt1)-d1(cnt1)*(q1*r1(cnt1)/Q1+c*(q1-Q1)^2);
           B2(cnt1) = p2(cnt1)*d2(cnt1)-d2(cnt1)*(q2*r1(cnt1)/Q1+c*(q2-Q1)^2); 
           
       end

       
         cnt1 = cnt1+1;
    end
    
    cnt1 = 1;
    legendInfo{n+1} = ['q1 = ' num2str(q1)];
    
    figure(1)
    subplot(2,3,1)
    aa(n+1) = plot( q2L:1:q2H,d1,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' B_1 demand,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,2)
    bb(n+1) =plot( q2L:1:q2H,p1,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' B_1 price,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,3)
    cc(n+1) =plot( q2L:1:q2H,B1,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' B_1 profit,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,4)
    dd(n+1) =plot( q2L:1:q2H,D1,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' S_1 demand,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,5)
    ff(n+1) =plot( q2L:1:q2H,r1,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' S_1 price,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,6)
    gg(n+1) =plot( q2L:1:q2H,U1,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' S_1 Profit,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    
    figure(2)
    subplot(2,3,1)
    hh(n+1) = plot(q2L:1:q2H,d2,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' B_2 demand,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,2)
    ii(n+1) =plot( q2L:1:q2H,p2,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' B_2 price,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,3)
    jj(n+1) =plot( q2L:1:q2H,B2,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' B_2 profit  ,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,4)
    kk(n+1) =plot( q2L:1:q2H,D2,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' S_2 demand,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,5)
    ll(n+1) =plot( q2L:1:q2H,r2,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf(' s_2 price,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on
    subplot(2,3,6)
    mm(n+1) =plot(q2L:1:q2H,U2,cstring(mod(n,8)+1),'LineWidth',2);
    tit = sprintf('S_2 profit  ,  Q_1 =  %d, Q_2 = %d  ', Q1, Q2);
    title(tit,'FontName','Times','fontsize',20,'fontweight','b');
    set(gca,'FontName','Times','fontsize',20,'fontweight','b') ;
    hold on

    n = n+1;
end


p1(p1==0)= NaN;
p2(p2==0)= NaN;
D1(D1==0)= NaN;
D2(D2==0)= NaN;
r1(r1==0)= NaN;
r2(r2==0)= NaN;




