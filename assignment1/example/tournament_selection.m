function best_index = tournament_selection(p1, p2, p1_index, p2_index)
    if p1 < p2
        best_index = p1_index;
    else
        best_index = p2_index;
    end
end