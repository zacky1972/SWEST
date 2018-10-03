# text2html.rb

ARGV.each do |path_txt|
	path_basename = File.basename(path_txt, ".*")
	path_html = "#{File.dirname(path_txt)}/#{path_basename}.html"
	f_txt = open(path_txt)
	f_html = open(path_html, "w")
	f_html.puts("<!DOCTYPE html><head><meta charset=\"UTF-8\"><title>#{path_basename}</title></head><body><p>")
	while line = f_txt.gets
		f_html.puts(line)
		f_html.puts("<br/>")
	end
	f_html.puts("</p></body>")
end