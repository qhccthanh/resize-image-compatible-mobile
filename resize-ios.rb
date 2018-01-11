require 'fileutils'
# require 'rmagick'

puts "Resizing image...."
system("mkdir resized")

Dir.glob('*').select { |f|

    file_extension = File.extname(f);
    file_name = f.split(".").first;
    accpet_ext = [".jpg", ".png", ".jpeg"];
    if accpet_ext.include?(file_extension)
        puts "Resizing #{f}"
        image_width = Integer(`/usr/local/bin/identify -format \"%[fx:w]\" \"#{f}\"`)
        image_height = Integer(`/usr/local/bin/identify -format \"%[fx:h]\" \"#{f}\"`)
        puts "Width: #{image_width} Height: #{image_height}"

        excute_1x = "sips #{f} -z #{image_height * 1.0/3} #{image_width * 1.0/3} --out resized/#{file_name}#{file_extension}"
        puts excute_1x
        system(excute_1x)

        excute_2x = "sips #{f} -z #{image_height * 2.0/3} #{image_width * 2.0/3}  --out resized/#{file_name}@2x#{file_extension}"
        puts excute_2x
        system(excute_2x)

        excute_3x = "sips #{f} -z #{image_height * 3.0/3} #{image_width * 3.0/3} --out resized/#{file_name}@3x#{file_extension}"
        puts excute_3x
        system(excute_3x)

        puts "\r\n --------------------- "
    end
}

puts "Done"