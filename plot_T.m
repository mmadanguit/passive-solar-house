

function plot_T(t,T)
    st = 50;
    figure;
    hold on
    plot(t(st:end)/(60*60*24),T(st:end,1),'r');
    plot(t(st:end)/(60*60*24),T(st:end,2),'b');
    yline(min(T(st:end,1)),'g-.');
    yline(max(T(st:end,1)),'r-.');

    legend('Inside Air', 'Absorber',[num2str(round(Tf(min(T(st:end,1))))) '\circ F min temp'], [num2str(round(max(Tf(T(st:end,1))))) '\circ F max temp'], 'location', 'best');
    title('Temperature of Inside Air and Absorber Over Time, 1 Week')
    xlabel('Time (days)')
    ylabel('Temperature (C)')

    ylim auto
    %ylim([0 40])
    yl = ylim;
    yyaxis right
    ylim manual
    ylim([Tf(yl(1)) Tf(yl(2))])
    ylabel('Temperature (F)')
    ax = gca;
    ax.YAxis(1).Color = 'blue';
    ax.YAxis(2).Color = 'red';

    hold off
end

function [tf] = Tf(tc)
    tf = tc*(9/5)+32;
end

function [tc] = Tc(tf)
    tc = (tf - 32)*5/9
end
