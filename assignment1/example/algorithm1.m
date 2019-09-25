function r = algorithm1()
    pop_size = 100;
    max_gen = 200;
    prob_crossover = 0.9;
    prob_mutation = 0.1;
    elitism = 0.1;
    x_min = -5;
    x_max = 5;

    the_best_in_each_gen = zeros(max_gen, 3);

    %% initialize the population
    pops = rand(pop_size, 2)*(x_max-x_min) - 5;

    for curr_gen = 1:max_gen
        %% fitness evaluation
        fitness = dejong1(pops(:,1), pops(:,2));

        %% generate offspring
        offspring = zeros(pop_size, 2);
        for i = 1:2:pop_size
            % select p1
            p1_candidate = randperm(pop_size, 2);
            p1 = tournament_selection(fitness(p1_candidate(1)), fitness(p1_candidate(2)), p1_candidate(1), p1_candidate(2));
            % select p2
            p2 = p1;
            while p2 == p1
                p2_candidate = randperm(pop_size, 2);
                p2 = tournament_selection(fitness(p2_candidate(1)), fitness(p2_candidate(2)), p2_candidate(1), p2_candidate(2));
            end
            % perform the crossover
            offspring1 = zeros(1, size(pops, 2));
            offspring2 = zeros(1, size(pops, 2));
            for j = 1:size(pops, 2)
                if rand() <= prob_crossover
                    [z1, z2] = sbx(pops(p1, j), pops(p2, j), x_min, x_max);
                    offspring1(j) = z1;
                    offspring2(j) = z2;
                else
                    offspring1(j) = pops(p1, j);
                    offspring2(j) = pops(p2, j);
                end
            end

            % performe the mutation
            for j = 1:size(pops, 2)
                if rand() <= prob_mutation
                    z = polynomial_mutation(offspring1(j), x_min, x_max);
                else
                    z = offspring1(j);
                end
                offspring1(j) = z;
            end

            for j = 1:size(pops, 2)
                if rand() <= prob_mutation
                    z = polynomial_mutation(offspring2(j), x_min, x_max);
                else
                    z = offspring2(j);
                end
                offspring2(j) = z;
            end

            offspring(i, :) = offspring1;
            offspring(i+1, :) = offspring2;

        end

        %% fitness evaluation for offspring
        fitness_offspring = dejong1(offspring(:,1), offspring(:,2));

        %% environmental selection
        total_solutions = [pops;offspring];
        total_fitness = [fitness;fitness_offspring];

        [~, I] = sort(total_fitness);
        new_pops = zeros(size(pops));
        new_pops(1:pop_size*elitism, :) = total_solutions(I(1:pop_size*elitism), :);
        for i = pop_size*elitism+1:pop_size
            p_candidate = randperm(pop_size*2, 2);
            p = tournament_selection(total_fitness(p_candidate(1)), total_fitness(p_candidate(2)), p_candidate(1), p_candidate(2));
            new_pops(i,:) = total_solutions(p,:);
        end

        % save for the analyzing
        the_best_in_each_gen(curr_gen, :) = [total_solutions(I(1), :), total_fitness(I(1))];
        
        % shuffle again
        I = randperm(pop_size);
        pops = new_pops(I,:);
    end
r = the_best_in_each_gen;
end