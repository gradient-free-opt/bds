function grouped_direction_indices = divide_direction_set(n, num_blocks, options)
%DIVIDE_DIRECTION_SET gets indices of the directions in each block.
%   GROUPED_DIRECTION_INDICES = DIVIDE_DIRECTION_SET(n, num_blocks) returns a cell, where
%   the grouped_direction_indices{i} contains the indices of the directions in the i-th block.
%   In our implementation, the direction set is in the form of [d_1, -d_1, d_2, -d_2, ..., d_n, -d_n], 
%   containing 2n directions. We divide the direction set into num_blocks blocks, with the first 
%   mod(n, num_blocks) blocks containing 2*(floor(n/num_blocks) + 1) directions and the rest 
%   containing 2*floor(n/num_blocks) directions. We also point out that d_i and -d_i will be in the same block
%   in our implementation.
%
%   Example
%     n = 11, num_blocks = 3.
%     The number of directions in each block is 4*2, 4*2, 3*2 respectively.
%     Thus grouped_direction_indices is a cell, where
%     grouped_direction_indices{1} = [1, 2, 3, 4, 5, 6, 7, 8],
%     grouped_direction_indices{2} = [9, 10, 11, 12, 13, 14, 15, 16],
%     grouped_direction_indices{3} = [17, 18, 19, 20, 21, 22].
%

% Detect whether the input is given in the correct type when debug_flag is true.
debug_flag = is_debugging();
if debug_flag
    % n should be a positive integer.
    if ~isintegerscalar(n) || n <= 0
        error('n is not a positive integer.');
    end
    % num_blocks should be a positive integer.
    if ~isintegerscalar(num_blocks) || num_blocks <= 0    
        error('num_blocks is not a positive integer.');
    end
    % The number of blocks should not be greater than the number of variables.
    if n < num_blocks
        error('The number of blocks should not be greater than the number of variables.');
    end
end

% Calculate the number of directions of each block.
% We try to make the number of directions in each block as even as possible. In specific, the first
% mod(n, num_blocks) blocks contain 2*(floor(n/num_blocks) + 1) directions and the rest contain 
% 2*floor(n/num_blocks) directions.
num_directions_each_block = ones(num_blocks, 1)*floor(n/num_blocks);
num_directions_each_block(1:mod(n, num_blocks)) = num_directions_each_block(1:mod(n, num_blocks)) + 1;
% To ensure that d_i and -d_i are assigned to the same block, we double the number of directions in each block.
num_directions_each_block = num_directions_each_block*2;

% Get the indices of directions in each block.
% The number of directions in each block might be different. Thus we use cell rather than matrix.
grouped_direction_indices = cell(1, num_blocks);
% We use cumsum function to get the initial index of each block.
initial_index_each_block = cumsum([1; num_directions_each_block(1:end-1)]);
for i = 1:num_blocks
    grouped_direction_indices(i) = {initial_index_each_block(i) : 1 : (initial_index_each_block(i) + num_directions_each_block(i) - 1)};
end

% Check whether the output is in the right type when debug_flag is true.
if debug_flag
    if length(grouped_direction_indices) ~= num_blocks
        error('The number of blocks of grouped_direction_indices is not correct.');
    end
end

end
