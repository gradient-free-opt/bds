function solver_legend = get_legend(parameters, i)
% GET_LEGEND gets the legend of i-th solver on performance profile.
%

switch parameters.solvers_options{i}.solver
    case {"bds"}
        solver_legend = upper(parameters.solvers_options{i}.Algorithm);

        if isfield(parameters.solvers_options{i}, "default")
            solver_legend = strcat(solver_legend, "-", "default");
        end

        if isfield(parameters.solvers_options{i}, "reduction_factor")
            for j = 1:length(parameters.solvers_options{i}.reduction_factor)
                if parameters.solvers_options{i}.reduction_factor(j) == 0
                    solver_legend = strcat(solver_legend, "-", ...
                        num2str(parameters.solvers_options{i}.reduction_factor(j)));
                elseif parameters.solvers_options{i}.reduction_factor(j) == eps
                    solver_legend = strcat(solver_legend, "-", "eps");
                else
                    solver_legend = strcat(solver_legend, "-", ...
                        int2str(int32(-log10(parameters.solvers_options{i}.reduction_factor(j)))));
                end
            end
        end

        if isfield(parameters.solvers_options{i}, "alpha_init_scaling") && ...
                parameters.solvers_options{i}.alpha_init_scaling
            solver_legend = strcat(solver_legend, "-", "alpha-init-scaling");
        end

        if isfield(parameters.solvers_options{i}, "forcing_function")
            if strcmp(func2str(parameters.solvers_options{i}.forcing_function), func2str(@(x)x.^2))
                solver_legend = strcat(solver_legend, "-", "quadratic");
            elseif strcmp(func2str(parameters.solvers_options{i}.forcing_function), func2str(@(x)x.^3))
                solver_legend = strcat(solver_legend, "-", "cubic");
            end
        end

        if isfield(parameters.solvers_options{i}, "forcing_function_type")
            solver_legend = strcat(solver_legend, "-", parameters.solvers_options{i}.forcing_function_type);
        end

        if isfield(parameters.solvers_options{i}, "permuting_period")
            solver_legend = strcat(solver_legend, "-", num2str(parameters.solvers_options{i}.permuting_period));
        end

        if isfield(parameters.solvers_options{i}, "cycling_inner")
            solver_legend = strcat(solver_legend, "-", num2str(parameters.solvers_options{i}.cycling_inner));
        end

        if isfield(parameters.solvers_options{i}, "replacement_delay")
            solver_legend = strcat(solver_legend, "-", num2str(parameters.solvers_options{i}.replacement_delay));
        end

        if isfield(parameters.solvers_options{i}, "block_indices_permuted_init")
            solver_legend = strcat(solver_legend, "-", "block-permuted-init");
        end

        if isfield(parameters.solvers_options{i}, "direction_set_type") ...
            && strcmpi(parameters.solvers_options{i}.direction_set_type, "randomized_orthogonal_matrix")
            solver_legend = strcat(solver_legend, "-", "randomized-orthogonal-matrix");
        end

        solver_legend = "our method";
        % if strcmpi(parameters.solvers_options{i}.Algorithm, "cbds")
        %     solver_legend = "new-method";
        % end

    case {"dspd"}
        solver_legend = "DSPD";
        if isfield(parameters.solvers_options{i}, "num_random_vectors")
            solver_legend = strcat(solver_legend, "-", num2str(parameters.solvers_options{i}.num_random_vectors));
        end

    case {"pds_xin"}
        solver_legend = "DSPD-Xin";

    case {"ds_xin"}
        solver_legend = "DS-Xin";

    case {"bds_powell"}
        solver_legend = "CBDS-Powell";

    case {"fminsearch_wrapper"}
        solver_legend = "fminsearch";

        if isfield(parameters.solvers_options{i}, "default")
            solver_legend = strcat(solver_legend, "-", "default");
        end

    case {"fminunc_wrapper"}
        
        %solver_legend = "fminunc";
        %solver_legend = upper(parameters.solvers_options{i}.fminunc_type);
        solver_legend = "FD-BFGS";

        if isfield(parameters.solvers_options{i}, "default")
            solver_legend = strcat(solver_legend, "-", "default");
        end

    case {"wm_newuoa"}
        solver_legend = "wm-newuoa";

    case {"nlopt_wrapper"}
        switch parameters.solvers_options{i}.Algorithm
            case "cobyla"
                solver_legend = "nlopt-cobyla";
            case "newuoa"
                solver_legend = "nlopt-newuoa";
            case "bobyqa"
                solver_legend = "nlopt-bobyqa";
            case "simplex"
                solver_legend = "nlopt-simplex";
        end

    case {"patternsearch"}
        solver_legend = "patternsearch";

    case {"lam"}
        solver_legend = "lam";
        if isfield(parameters.solvers_options{i}, "linesearch_type")
            solver_legend = strcat(solver_legend, "-", ...
                parameters.solvers_options{i}.linesearch_type);
        end

    case {"bfo_wrapper"}
        solver_legend = "BFO";

    case {"prima_wrapper"}
        solver_legend = upper(parameters.solvers_options{i}.Algorithm);

    case {"imfil_wrapper"}
        solver_legend = "imfil";

    case {"nomad_wrapper"}
        solver_legend = "nomad";

end

end
