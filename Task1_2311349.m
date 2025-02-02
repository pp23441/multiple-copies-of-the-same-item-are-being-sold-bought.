% Task 1
%% a.
% Initialize variables
num_replications = 10;
num_rounds = 5;
num_buyers = 3;
valuations = [10, 8, 6];
total_profit_replications = zeros(num_replications, 1);
total_social_welfare_replications = zeros(num_replications, 1);

% Main loop for replications
for rep = 1:num_replications
    % Initialize arrays for profit and social welfare 
    profits = zeros(num_buyers, num_rounds);
    social_welfare = zeros(1, num_rounds);

    % Round loop
    for round = 1:num_rounds
        % Generate bids for each buyer
        bids = randi([1, max(valuations)], num_buyers, 1);

        % Sort bids in descending order
        [sorted_bids, sorted_indices] = sort(bids, 'descend');

        % Select top 2 bids
        top_bids = sorted_bids(1:2);

        % Calculate profit for each buyer
        for buyer = 1:num_buyers
            if any(sorted_indices(1:3) == buyer)
                profits(buyer, round) = valuations(buyer) - sorted_bids(3);
            else
                profits(buyer, round) = 0;
            end
        end

        % Calculate social welfare for the round
        social_welfare(round) = sum(valuations);

    end

    % Calculate total profit and social welfare for the replication
    total_profit_replications(rep) = sum(sum(profits));
    total_social_welfare_replications(rep) = sum(social_welfare);

    % Display results for each replication
    fprintf('(Replication %d)\n', rep);
    fprintf('Round\tProfit of Buyer 1\tProfit of Buyer 2\tProfit of Buyer 3\tSocial Welfare\n');
    for round = 1:num_rounds
        fprintf('%d\t\t%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\n', round, profits(1, round), profits(2, round), profits(3, round), social_welfare(round));
    end
    fprintf('Total (Rounds 1-%d)\t%.2f\n\n', num_rounds, sum(sum(profits)));
end

% Calculate average total profit and social welfare across all replications
avg_total_profit = mean(total_profit_replications);
avg_social_welfare = mean(total_social_welfare_replications);

% Display average results across all replications
fprintf('Average total profit for %d replications: %.2f\n', num_replications, avg_total_profit);
fprintf('Average social welfare for %d replications: %.2f\n', num_replications, avg_social_welfare);

%% b.
% Initialize variables
valuations = [10, 8, 6];
equilibria = [];
equilibria_social_welfare = [];

% Generate all possible bidding combinations
for bid_buyer1 = 1:valuations(1)
    for bid_buyer2 = 1:valuations(2)
        for bid_buyer3 = 1:valuations(3)
            % Check if the bids form an equilibrium
            if (bid_buyer1 > bid_buyer2 && bid_buyer1 > bid_buyer3) || ...
               (bid_buyer2 > bid_buyer1 && bid_buyer2 > bid_buyer3) || ...
               (bid_buyer3 > bid_buyer1 && bid_buyer3 > bid_buyer2)
                % Calculate social welfare
                social_welfare = bid_buyer1 + bid_buyer2 + bid_buyer3;
                % Store equilibrium and its social welfare
                equilibria = [equilibria; bid_buyer1, bid_buyer2, bid_buyer3];
                equilibria_social_welfare = [equilibria_social_welfare; social_welfare];
            end
        end
    end
end

% Display equilibria and social welfare
fprintf('Equilibrium\tBuyer 1\tBuyer 2\tBuyer 3\tSocial Welfare\n');
for i = 1:size(equilibria, 1)
    fprintf('%d\t\t%d\t\t%d\t\t%d\t\t%d\n', i, equilibria(i, :), equilibria_social_welfare(i));
end

% Calculate average social welfare
avg_social_welfare = mean(equilibria_social_welfare);
fprintf('Average social welfare for all equilibria: %.2f\n', avg_social_welfare);