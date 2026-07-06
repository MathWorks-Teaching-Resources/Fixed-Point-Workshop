function compareFIRExerciseWithSolution
    exercise = fullfile(workshopRoot,'exercises','04conversion_with_fir_filter','fir_filter.m');
    solution = fullfile(workshopRoot,'solutions','04conversion_with_fir_filter','fir_filter.m');
    visdiff(exercise,solution)
end