clc;clear;

runs = 30;

% answer for step3
% results = zeros(runs, 1);
% for i = 1:runs
%     r = algorithm1();
%     results(i) = r(end, 3);
% end

%fprintf('mean value:%f, std:%f\n', mean(results), std(results));

% part answer for step4
r = algorithm1();
total_gen = size(r, 1);
fitness_of_each_gen = r(:, end);
plot(1:total_gen, fitness_of_each_gen);
xlabel('The Number of Generation');
ylabel('The fitness');