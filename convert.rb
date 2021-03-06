#!/usr/bin/env ruby

cur_dir = File.absolute_path(__FILE__).sub(File.basename(__FILE__), "")

Dir.mkdir "output" unless Dir.exist?("output")

Dir.foreach(cur_dir) do |file|
	if File.file?(file) && File.extname(file) =~ /\.flv|\.mp4/i
		flv_name = File.join(cur_dir, file)

		mp3_name = file.gsub(/flv|FLV|mp4|MP4/, 'mp3')
		mp3_name = File.join(cur_dir, "output", mp3_name)

    # tried to parallelize the conversion - possible race condition on IO writing, using a mutex would be equal to normal queed conversion
		# pid = spawn('ffmpeg -i "'+flv_name+'" "'+mp3_name+'"')
    # Process.detach(pid)

    `ffmpeg -i "#{flv_name}" "#{mp3_name}"`
	end
end

Dir.unlink("output") if Dir.entries("output").length <= 2

p "Conversion done"
