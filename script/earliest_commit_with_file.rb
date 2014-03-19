def file_exists? sha, file
  all_files = `git ls-tree --name-only -r #{sha}`.lines

  all_files.any? { |a_file| a_file.match file }
end

rev_with_file = `git rev-list --all`.split("\n").inject("No where...") do |rev_with_file, rev|
  if file_exists? rev, ARGV.first
    rev
  else
    rev_with_file
  end
end

puts rev_with_file
