function array = cycling(array, index, strategy, memory)
%CYCLING Permutation an array with index and different options
%   ARRAY = CYCLING(ARRAY, INDEX, STRATEGY, MEMORY) returns an array
%   using cycling_strategy and memory with index. ARRAY can be a vevtor.
%   MEMORY is boolean value. STRATEGY is a nonnegative integer from 0 to 4.
%   INDEX is a nonnegative number from -1, 1, ..., length(array).
%   If INDEX = -1, then there is no permutation.
%   memory - If memory is true, permutation will be executed on the array of last
%           iteration, otherwise, permutation will be executed on the initial array.
%   cycling_strategy - Possible values of cycling and the corresponding conditions
%                      are listed below. 
%
%   0  No permutation. 
%
%   1  The element of the index will be moved to the first element of array.
%
%   EXAMPLE 
%   When array is 3 1 2 4 5, if index = 3, for memory situation, 
%   array will be 2 3 1 4 5 after cycling; for nonmemory situaion, index 
%   will be 2, sort(index) is 1 2 3 4 5 and array will be 2 1 3 4 5 after 
%   cycling.
%
%   2  The element of the index and the following ones until end will be
%      moved ahead of array.
%
%   EXAMPLE
%   When array is 2 1 4 5 3, if index = 3, for memory situation, 
%   array will be 4 5 3 2 1 after cycling; for nonmemory situaion, index 
%   will be 4, sort(index) is 1 2 3 4 5 and array will be 4 5 1 2 3 after 
%   cycling.
%
%   3  The element of the following ones after index until end will be 
%      moved ahead of array.
%   
%   EXAMPLE 
%   When array is 2 1 4 5 3 and index = 3, for memory situation, 
%   array will be 5 3 2 1 4 after cycling; for nonmemory situaion, index will
%   be 4, sort(index) is 1 2 3 4 5 and array will be 5 1 2 3 4 after cycling.
%   
%   4  The element of the following one after index will be moved ahead of array.
%   
%   EXAMPLE  
%   array is 4 1 2 3 5, if index = 3, for memory situation, array will 
%   be 3 4 1 2 5 after cycling; for nonmemory situaion, index will be 2, 
%   sort(index) is 1 2 3 4 5 and array will be 3 1 2 4 5 after cycling.
%
%


% Precondition: If debug_flag is true, then pre-conditions is operated on
% input. If input_correctness is false, then assert may let the code crash.
debug_flag = is_debugging();
if debug_flag
    % Assert array is a real vector.
    [isrv, ~]  = isrealvector(array);
    assert(isrv);
    % Assert index is an integer.
    assert(isintegerscalar(index));
    % Assert strategy is a positive integer and less than or equal to 4.
    assert(isintegerscalar(strategy) && 0<=strategy && strategy<=4);
    % Assert memory is boolean value.
    assert(islogicalscalar(memory));
end

%   If index < 0, then there is no "success_index" and there is no
%   permutation. If strategy == 0, then the permutation is unchanged.
if index < 0 || strategy == 0
    return;
end

% If memory is true, cycling_strategy will be operated on array. Otherwise,
% cycling_strategy will be operated on the array after sorting. In this case,
% the value of index will be the index corresponding to the array after sorting.
if ~memory
    [array, indices] = sort(array);
    index = find(indices == index);
end

switch strategy
    % If cycling_strategy is 1, the element of the index will be moved to 
    % the first element of array. For example, if index = 3, array is 1 2 3 4 5, 
    % then array will be 3 1 2 4 5 after cycling. For the case where 
    % array is 3 1 2 4 5, if index = 3, for memory situation, array will 
    % be 2 3 1 4 5 after cycling; for nonmemory situaion, index will 
    % be 2 after executing the code paragraph above, sort(index) 
    %is 1 2 3 4 5 and array will be 2 1 3 4 5 after cycling.
    case {1}
        array(1:index) = array([index, 1:index-1]);
    % If cycling_strategy is 2, the element of the index and the following 
    % ones until end will be moved ahead of array. For example, if index = 3, 
    % array is 1 2 3 4 5, then array will be 3 4 5 1 2 after cycling. 
    % When array is 2 1 4 5 3, if index = 3, for memory 
    % situation, array will be 4 5 3 2 1 after cycling; for nonmemory 
    % situaion, index will be 4 after executing the paragraph above, 
    % sort(index) is 1 2 3 4 5 and array will be 4 5 1 2 3 after cycling.
    case {2}
        array = array([index:end, 1:index-1]);
    % If cycling_strategy is 3, the element of the following ones after index
    % until end will be moved ahead of array. For example, if index = 3, array 
    % is 1 2 3 4 5, then array will be 4 5 1 2 3 after cycling. 
    % When array is 2 1 4 5 3 and index = 3, for memory 
    % situation, array will be 5 3 2 1 4 after cycling; for nonmemory 
    % situaion, index will be 4 after executing the paragraph above, 
    % sort(index) is 1 2 3 4 5 and array will be 5 1 2 3 4 after cycling.
    case {3}
        array = array([index+1:end, 1:index]);
    % If cycling_strategy is 4, the element of the following one after index
    % will be moved ahead of array. For example, if index = 3, array 
    % is 1 2 3 4 5, then array will be 4 1 2 3 5 after cycling. 
    % For the case where array is 4 1 2 3 5, if index = 3, for memory 
    % situation, array will be 3 4 1 2 5 after cycling; for nonmemory 
    % situaion, index will be 2 after executing the paragraph above, 
    % sort(index) is 1 2 3 4 5 and array will be 3 1 2 4 5 after cycling.
    case {4}
        if index ~= length(array)
            array(1:index+1) = array([index+1, 1:index]);
        end       
end

if debug_flag
    % Assert array is a vector.
    [isrv, ~]  = isrealvector(array);
    assert(isrv);
end