%%
% In this file a game with 3 brokers and 2 providers are simulated where
% brokers B_2 and B_3 cooperate to maximize the profit.
% At the end, extra profit  that they made split in proportion to their 
% profit in the equilibrium of the non-cooperative game when B_2 maximize its profit 
% q_1 and q_3 are fixed
% B_2 changes qauality in the game to simulate the market with different
% qualities 
% Qi, ri, Di & SUi are quality, price, demand and profit of S_i
% qi, Pi, di & BUi are quality, price, demand and profit of B_i
%%
clc
clear
cstring = '.*o';
mx = 80;
mn = 1;
c = .2;
Q1 = 30;
Q2 = 60;
cnt1 = 1;
n = 3;
k1 = .01265*Q1^1.5;
 k2 = .01265*Q2^1.5;
 cnt = 1;
 step = 2;
 clear d1 d2 d3 d4 p1 p2 p3 p4 r1 r2 BU1 BU2 BU3 BU4 SU1 SU2 D1 D2

 q1 = 10;
 q3 =90;
 q2l = q1+3;
 q2h = q3-3;
 for q2 = q2l:step:q2h 
      if abs(q2-Q1)<abs(q2-Q2) % B2 picks the providers that gap of their quality is less
        r1(cnt) = 1/(Q2*(8*q1*(q2-q3)+q2*(q2+8*q3)))*(2*k1*Q2*(2*q1*(q2-q3)+q2*(q2+2*q3))+Q1*(4*mn*(2*q1+q2)*...
            Q2*(q2-q3)+3*k2*q2*q3+c*Q2*(-4*q1^2*(q2-q3)+8*q1*Q1*(q2-q3)+q2*(-3*Q1^2+q2^2-2*Q1*(q2-4*q3)+...
            3*(Q2-q3)^2-4*q2*q3))-4*q1*q2*Q2*mx-5*q2^2*Q2*mx+4*q1*Q2*q3*mx+5*q2*Q2*q3*mx));
        r2(cnt) =-(1/(Q1*q3*(8*q1*(q2-q3)+q2*(q2+8*q3))))*(-k1*q2*Q2*(2*q1*(q2-q3)+q2*(q2+2*q3))-c*...
            Q1*Q2*(-2*q1^2*q2*(q2-q3)+4*q1*(Q1^2-Q1*q2+q2^2-(Q2-q3)^2)*(q2-q3)+q2*(q2^3-Q1^2*...
            (q2-4*q3)+q2*(Q2-q3)^2+2*q2^2*q3-4*(Q2-q3)^2*q3-2*Q1*q2*(q2+2*q3)))+Q1*(-2*mn*q2*(2*q1+q2)*...
            Q2*(q2-q3)-2*k2*q3*(2*q1*q2+q2^2-2*q1*q3+2*q2*q3)+Q2*(q2-q3)*(6*q1*q2+3*q2^2-4*q1*q3+4*q2*q3)*mx));

        if q2/Q2*r2(cnt)+c*(q2-Q2)^2-(q2/Q1*r1(cnt)+c*(q2-Q1)^2)<0
            r1(cnt) = -(1/(q2*Q2*(q2-2*q3)))*Q1*(c*Q2*(q2^3+Q1^2*(q2-2*q3)-2*Q1*q2*...
                (q2-2*q3)+2*Q2^2*q3-q2*(Q2+q3)^2)+q2*(k2*q3+Q2*(-q2+q3)*mx));
            r2(cnt) = (c*Q1*Q2*(Q1^2-2*Q1*q2+q2^2-(Q2-q3)^2)+k2*Q1*q3+Q2*(Q1*q3*mx+q2*(r1(cnt)-Q1*mx)))/(2*Q1*q3);

        end
        p1(cnt) = (1/(3*Q1))*(2*mn*Q1*(q1-q2)+c*Q1*(2*q1^2-4*q1*Q1+3*Q1^2-2*Q1*q2+q2^2)+2*q1*r1(cnt)+q2*r1(cnt)-q1*Q1*mx+Q1*q2*mx);
        p2(cnt) = (1/(3*Q1))*(mn*Q1*(q1-q2)+c*Q1*(q1^2-2*q1*Q1+3*Q1^2-4*Q1*q2+2*q2^2)+q1*r1(cnt)+2*q2*r1(cnt)-2*q1*Q1*mx+2*Q1*q2*mx);
        p3(cnt) = (1/(6*Q1*Q2))*(2*mn*Q1*(q1-q2)*Q2+c*Q1*Q2*(2*q1^2-4*q1*Q1+3*Q1^2-2*Q1*q2+q2^2+3*Q2^2-6*...
            Q2*q3+3*q3^2)+2*q1*Q2*r1(cnt)+q2*Q2*r1(cnt)+3*Q1*q3*r2(cnt)-4*q1*Q1*Q2*mx+Q1*q2*Q2*mx+3*Q1*Q2*q3*mx);

        d1(cnt) = (((p2(cnt)-p1(cnt))/(q2-q1))-mn)/(mx-mn);
        d2(cnt) = (((p3(cnt)-p2(cnt))/(q3-q2))-((p2(cnt)-p1(cnt))/(q2-q1)))/(mx-mn);
        d3(cnt) = (mx - ((p3(cnt)-p2(cnt))/(q3-q2)))/(mx-mn);
        D1(cnt) = d1(cnt)+d2(cnt);
        D2(cnt) = d3(cnt);
        BU1(cnt) = d1(cnt)*(p1(cnt)-(q1/Q1*r1(cnt)+c*(q1-Q1)^2));
        BU2(cnt) = d2(cnt)*(p2(cnt)-(q2/Q1*r1(cnt)+c*(q2-Q1)^2));
        BU3(cnt) = d3(cnt)*(p3(cnt)-(q3/Q2*r2(cnt)+c*(q3-Q2)^2));
        SU1(cnt) = (d1(cnt)*q1/Q1+d2(cnt)*q2/Q1)*(r1(cnt)-k1);
        SU2(cnt) = (d3(cnt)*q3/Q2)*(r2(cnt)-k2);


      else
        r1(cnt) = 1/(6*q1*Q2*(-q2*(q2-2*q3)+2*q1*(q2-q3)))*(-k2*Q1*q2*(-3*q1*q2+q2^2+3*q1*q3-3*q2*q3)+Q2*...
            (2*k1*q1*(-q2*(q2-3*q3)+3*q1*(q2-q3))-Q1*(-2*mn*(q1-q2)*(-q2*(q2-6*q3)+6*q1*(q2-q3))+c*...
            (-2*q1^2*(q2*(2*q2-3*q3)+6*Q1*(q2-q3))+6*q1^3*(q2-q3)+q2*(q2^3-6*Q2^2*q3-2*q2^2*(Q2+3*q3)+Q1^2*...
            (-4*q2+6*q3)+q2*(4*Q2^2+6*Q2*q3+3*q3^2))+q1*(4*Q1*q2*(2*q2-3*q3)+6*Q1^2*(q2-q3)-3*(q2-q3)*...
            (q2^2+2*Q2^2-q2*(2*Q2+q3))))+(q1-q2)*(-q2*(q2-9*q3)+6*q1*(q2-q3))*mx)));
        r2(cnt) = -(1/(3*Q1*(-2*q1*q2+q2^2+2*q1*q3-2*q2*q3)))*(-k2*Q1*(-3*q1*q2+q2^2+3*q1*q3-3*q2*q3)+Q2*...
            (k1*q1*q2+Q1*(4*mn*(q1-q2)*q2+c*(q1^2*q2+q2*(Q1^2+2*q2^2-4*q2*Q2-Q2^2+6*Q2*q3-3*q3^2)+q1*...
            (-2*Q1*q2-3*(q2-q3)*(q2-2*Q2+q3)))-(q1-q2)*(2*q2+3*q3)*mx)));

        if (q2/Q1*r1(cnt)+c*(q2-Q1)^2)-(q2/Q2*r2(cnt)+c*(q2-Q2)^2)<0
            r2(cnt) = (Q2*(c*Q1*(q1^2*q2-q2*(-Q1^2+(q2-Q2)^2)-2*q1*(Q1^2-Q1*q2+...
                (2*q2-Q2)*Q2))+q2*(-k1*q1-Q1*(q1-q2)*(2*mn-mx))))/(Q1*q2*(-2*q1+q2));
            r1(cnt) = (k1*q1*Q2+Q1*(2*mn*(q1-q2)*Q2+c*(-q1^2+2*q1*Q1-Q1^2+(q2-Q2)^2)*Q2+q2*r2(cnt)-q1*Q2*mx+q2*Q2*mx))/(2*q1*Q2);

        end
        if (q1/Q2*r2(cnt)+c*(q1-Q2)^2)-(q1/Q1*r1(cnt)+c*(q1-Q1)^2)<0
            r1(cnt) = 1/(2*q1*Q2*(2*q1*q2-q2^2-3*q1*q3+3*q2*q3))*Q1*(k2*q1*(-q2*(q2-3*q3)+3*q1*(q2-q3))+Q2*...
                (2*mn*q1*(q1-q2)*q2+c*(2*q1^3*q2+2*q2*(Q1^2-Q2^2)*(q2-3*q3)+q1^2*(4*Q1*(2*q2-3*q3)-3*...
                (q2-q3)*(q2+2*Q2+q3))+q1*(q2^3+2*q2^2*Q2+4*q2*Q2^2-4*Q1*q2*(q2-3*q3)-6*q2*Q2*q3-6*...
                Q2^2*q3-3*q2*q3^2+Q1^2*(-4*q2+6*q3)))-q1*(q1-q2)*(q2+3*q3)*mx));

            r2(cnt) = -(1/(2*Q1*(-3*q1*q2+q2^2+3*q1*q3-3*q2*q3)))*(-k2*Q1*(-3*q1*q2+q2^2+3*q1*q3-3*q2*q3)+...
                Q2*(2*mn*Q1*(q1-q2)*q2+c*Q1*(2*q1^2*q2+q2*(2*Q1^2+q2^2-2*q2*Q2-2*Q2^2+6*Q2*q3-3*q3^2)+q1*...
                (-4*Q1*q2-3*(q2-q3)*(q2-2*Q2+q3)))+2*q1*q2*r1(cnt)-q1*Q1*q2*mx+Q1*q2^2*mx-3*q1*Q1*q3*mx+3*Q1*q2*q3*mx));
        end


        p1(cnt) = (2*mn*Q1*(q1-q2)*Q2+c*Q1*(2*q1^2-4*q1*Q1+2*Q1^2+(q2-Q2)^2)*Q2+2*q1*Q2*r1(cnt)+Q1*q2*r2(cnt)-q1*Q1*Q2*mx+Q1*q2*Q2*mx)/(3*Q1*Q2);
        p2(cnt) = (mn*Q1*(q1-q2)*Q2+c*Q1*(q1^2-2*q1*Q1+Q1^2+2*(q2-Q2)^2)*Q2+q1*Q2*r1(cnt)+2*Q1*q2*r2(cnt)-2*q1*Q1*Q2*mx+2*Q1*q2*Q2*mx)/(3*Q1*Q2);
        p3(cnt) = (2*mn*Q1*(q1-q2)*Q2+c*Q1*Q2*(2*q1^2-4*q1*Q1+2*Q1^2+q2^2-2*q2*Q2+4*Q2^2-6*Q2*q3+3*q3^2)+2*...
            q1*Q2*r1(cnt)+Q1*q2*r2(cnt)+3*Q1*q3*r2(cnt)-4*q1*Q1*Q2*mx+Q1*q2*Q2*mx+3*Q1*Q2*q3*mx)/(6*Q1*Q2);


        if  (mx - ((p3(cnt)-p2(cnt))/(q3-q2)))/(mx-mn)<.001
            r1(cnt) = nan;
            r2(cnt) = nan;
            p1(cnt) = nan;
            p2(cnt) = nan;
            p3(cnt) = nan;


        end

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
      TU(cnt) = BU2(cnt) + BU3(cnt);
      BS2(cnt) = 394 + (TU(cnt) - 515)*(394/515);%(q2/(q3+q2));
      BS3(cnt) = 121 + (TU(cnt) - 515)*(121/515);%(q3/(q3+q2));


      cnt = cnt+1; 

 end

 figure(1)
 p1p(n)= plot(q2l:step:q2h,r1,'b','LineWidth',3);
 hold on
 p2p(n)=plot(q2l:step:q2h,r2,'r','LineWidth',3);
 titPP = sprintf('Providers Price, B_2 and B_3 cooperate, q_1 =  %d, q_3 = %d  ', q1, q3);
 title(titPP,'FontName','Times','fontsize',15,'fontweight','b');
 xlabel('Quality of service offered by B_2');
 legend('S_1','S_2');
 set(gca,'FontName','Times','fontsize',15,'fontweight','b') ;


 figure(2)
 b1d(n)= plot(q2l:step:q2h,d1,'b','LineWidth',3);
 hold on
 b2d(n) = plot(q2l:step:q2h,d2,'r', 'LineWidth',3);
 hold on
 b3d(n) = plot(q2l:step:q2h,d3,'k','LineWidth',3);
 titBD = sprintf('Brokers Demand, B_2 and B_3 cooperate,  q_1 =  %d, q_3 = %d  ', q1, q3);
 title(titBD,'FontName','Times','fontsize',15,'fontweight','b');
 xlabel('Quality of service offered by B_2');
 legend('B_1','B_2','B_3');
 set(gca,'FontName','Times','fontsize',15,'fontweight','b') ;


 figure(3)
 p1d(n) = plot(q2l:step:q2h,D1,'b','LineWidth',3);
 hold on
 p2d(n) = plot(q2l:step:q2h,D2,'r','LineWidth',3);
 titPD = sprintf('Providers Demand, B_2 and B_3 cooperate, q_1 =  %d, q_3 = %d  ', q1, q3);
 xlabel('Quality of service offered by B_2');
 legend('S_1','S_2');
 title(titPD,'FontName','Times','fontsize',15,'fontweight','b');
 set(gca,'FontName','Times','fontsize',15,'fontweight','b') ;

 figure(4)
 b1p(n) = plot(q2l:step:q2h,p1,'b','LineWidth',3);
 hold on
 b2p(n) = plot(q2l:step:q2h,p2,'r','LineWidth',3);
 hold on
 b3p(n) = plot(q2l:step:q2h,p3,'k','LineWidth',3);
 titBP = sprintf('Brokers Price, B_2 and B_3 cooperate, q_1 =  %d, q_3 = %d  ', q1, q3);
 xlabel('Quality of service offered by B_2');
 legend('B_1','B_2','B_3');
 title(titBP,'FontName','Times','fontsize',15,'fontweight','b');
 set(gca,'FontName','Times','fontsize',15,'fontweight','b');

 figure(5)

 b1u(n) = plot(q2l:step:q2h,BU1,'b','LineWidth',3);
 hold on
 b2u(n) = plot(q2l:step:q2h,BS2,'r','LineWidth',3);
 hold on
 b3u(n) = plot(q2l:step:q2h,BS3,'k','LineWidth',3);
 hold on 
 titBU = sprintf('Brokers Profit, B_2 and B_3 cooperate, q_1 =  %d, q_3 = %d  ', q1, q3);
 xlabel('Quality of service offered by B_2');
 legend('B_1','B_2','B_3');
 title(titBU,'FontName','Times','fontsize',15,'fontweight','b');
 set(gca,'FontName','Times','fontsize',15,'fontweight','b');

 figure(6)
 p1u(n) = plot(q2l:step:q2h,SU1,'b','LineWidth',3);
 hold on
 p2u(n) = plot(q2l:step:q2h,SU2,'r','LineWidth',3);
 titPU = sprintf('Providers Profit, B_2 and B_3 cooperate, q_1 =  %d, q_3 = %d  ', q1, q3);
 xlabel('Quality of service offered by B_2');
 legend('S_1','S_2');
 title(titPU,'FontName','Times','fontsize',15,'fontweight','b');
 set(gca,'FontName','Times','fontsize',15,'fontweight','b') ;










