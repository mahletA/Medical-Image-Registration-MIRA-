% Generate bar plot

MI = [4.2228 4.5931   0.6706   3.9068
      1.0918 1.0329   0.7390   2.4326
      0.3562 0.3402   0.7371   2.5883]';

str = {'sd'; 'cc'; 'gcc'; 'multiple R.'};
bar(MI, 'group');
set(gca, 'XTickLabel',str, 'XTick',1:numel(str));
title('Mutual Information of different registration results');
ylabel('MI');
xlabel('Metrics');
legend({'Im1 to Im2','Im1 to Im3','Im1 to Im4'},'Location','northeast');
saveas(gcf,'./Results/result_plot.png');

