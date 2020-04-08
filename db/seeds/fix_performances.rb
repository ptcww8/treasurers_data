Performance.all.each do |perf|
	if perf.branch_id.to_i.to_s == perf.branch_id
	  branch = User.find_by_id(perf.completed_by).treasurer.branch_id
	  perf.branch_id = branch
	  perf.save
	end
end