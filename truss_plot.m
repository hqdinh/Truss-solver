function truss_plot(nodes, els, els_real, els_amp, amp, prop, prop_name)
    % nodes = all nodes' information
    % els = all elements' information
    % els_real = all elements with real deformation 
    % els_amp = all elements with amplified deformation
    % amp = deformation factor
    % prop = the property the color bar is based on. Could be stress,
    %        strain, section, stiffness, etc ... 
    % prop_name = the label of the color bar
    
    x = nodes(:,2); y = nodes(:,3);
    x1 = min(x); x2 = max(x); y1 = min(y); y2 = max(y);
    xrange = x2 - x1;
    yrange = y2 - y1;
     
    g1 = figure; 
    format_plot(gca, gcf)
    hold on
    plot_els(els, ':k', 1);
    plot_nodes(nodes, 'b');
    title('Truss Schematics')
    xlim([x1-0.05*xrange, x2+0.05*xrange])
    ylim([y1-0.05*yrange, y2+0.05*yrange])     

    g2 = figure;
    format_plot(gca, gcf)
    hold on
    plot_els(els, '-.r', 0);
    plot_els(els_amp, 'b', 0);
    h = zeros(2, 1);
    h(1) = plot(-NaN,-NaN,'-.r');
    h(2) = plot(-NaN,-NaN,'-b'); 
    legend(h, 'Undeformed', [num2str(amp) 'x Deformed'], 'Location', 'NorthEast') 
    title('Exaggerated Deformation')
    xlim([x1-0.1*xrange, x2+0.15*xrange])
    ylim([y1-0.1*yrange, y2+0.15*yrange])
    
    g3 = figure;
    format_plot(gca, gcf)
    plot_els_fringe(els_real, prop, prop_name)
    title('Deformed State')
    
    figure
    subplot(2,1,1)
    
    
    
end

function plot_nodes(nodes, color)
    ids = num2str(nodes(:,1));
    x = nodes(:,2);
    y = nodes(:,3);
    
    for i=1:length(ids)
        text(x, y, ids, 'color', color, 'FontWeight', 'normal')
    end
end

function plot_els(els, option, show_el)  
    % for each row = [x1 y1 x2 y2]  
    d = (min(els(:,8)) + max(els(:,8))) / 40; 
    x1 = els(:,4);
    y1 = els(:,5);
    x2 = els(:,6);
    y2 = els(:,7);
    x_ = (x1+x2) / 2 - d;
    y_ = (y1+y2) / 2 ;
    el_ids = num2str(els(:,1));
    hold on
    for i=1:length(x1)
        plot([x1(i) x2(i)], [y1(i) y2(i)], option, 'LineWidth', 0.05);
    end
    
    if show_el
        text(x_, y_, el_ids, 'color', 'r'); 
    end
end

function plot_els_fringe(els, prop, prop_name)
    format shortE
    % for each row = [x1 y1 x2 y2]  
    sigma1 = min(prop);
    sigma2 = max(prop);
    k = (prop - sigma1) ./ (sigma2 - sigma1);
    colors = rainbow2rgb(k);
    x1 = els(:,4);
    y1 = els(:,5);
    x2 = els(:,6);
    y2 = els(:,7);  
    % plot elements
    hold on
    for i=1:length(x1)
        plot([x1(i) x2(i)], [y1(i) y2(i)], 'color', colors(i,:), 'LineWidth', 2);
    end
    
    x = [x1; x2]; y = [y1; y2];
    xrange = max(x) - min(x);
    yrange = max(y) - min(y);
    xlim([min(x) - 0.05*xrange, max(x) + 0.32*xrange])
    ylim([min(y) - 0.05*yrange, max(y) + 0.05*yrange])
    
    dx = 0.07 * xrange;
    dy = 0.7 * yrange;
    x0 = max(x) + 0.05*xrange;
    y0 = min(y) + 0.25*yrange;
    
    % plot color bar
    k = linspace(0, 1, 200);
    colors = rainbow2rgb(k);
    for i=1:length(k)
        plot([x0, x0+dx], [y0, y0]+k(i)*dy, 'color', colors(i,:), 'LineWidth', 2) 
    end    
    
    n = 10; 
    legs = linspace(sigma1, sigma2, n)';
    legs = strcat({' '}, num2str(legs,'%12.2e'));    
    y_pos = linspace(y0, y0+dy, n);
    x_pos = x0 + dx;
    % annotate color bar
    for i=1:n
        text(x_pos, y_pos(i), legs(i), 'color', 'w') 
    end
    text(x_pos, y0 + 1.075*dy, ['  ' prop_name], 'color', 'w')
    set(gca,'Color','k')    
end
   
function format_plot(ax, fig)  
    set(fig, 'position', [0 100 900 300]);
    outerpos = ax.OuterPosition;
    ti = ax.TightInset*2;
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - 2*ti(3);
    ax_height = outerpos(4) - ti(2) - 2*ti(4);
    ax.Position = [left bottom ax_width ax_height];
end