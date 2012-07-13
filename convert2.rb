#!/usr/bin/env ruby

cur_dir = File.absolute_path(__FILE__).sub(File.basename(__FILE__), "")

Dir.mkdir "mp4" unless Dir.exist?("mp4")

Dir.foreach(cur_dir) do |file|
	if File.file?(file) && File.extname(file) =~ /\.flv/i
		flv_name = File.join(cur_dir, file)

		mp4_name = file.gsub(/flv|FLV/, 'mp4')
		mp4_name = File.join(cur_dir, "mp4", mp4_name)

    	`ffmpeg -i "#{flv_name}" -sameq -ar 22050 "#{mp4_name}"`
	end
end

Dir.unlink("mp4") if Dir.entries("mp4").length <= 2

p "Conversion done"