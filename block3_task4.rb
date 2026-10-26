require 'fileutils'
require 'date'

def add_date_to_txt_files(dir_path)
  current_date = Time.now.strftime("%Y-%m-%d")
  files = Dir.glob(File.join(dir_path, "*.txt"))
  
  renamed_files = []
  files.each do |filepath|
    filename = File.basename(filepath)
    next if filename =~ /^\d{4}-\d{2}-\d{2}_/
    
    new_filepath = File.join(File.dirname(filepath), "#{current_date}_#{filename}")
    FileUtils.mv(filepath, new_filepath)
    renamed_files << File.basename(new_filepath)
  end
  renamed_files
end

def add_date_to_txt_files_alternative(dir_path)
  current_date = Date.today.strftime("%Y-%m-%d")
  renamed_files = []
  
  Dir.children(dir_path).each do |filename|
    next unless filename.end_with?(".txt")
    next if filename =~ /^\d{4}-\d{2}-\d{2}_/
    
    old_filepath = File.join(dir_path, filename)
    new_filepath = File.join(dir_path, "#{current_date}_#{filename}")
    File.rename(old_filepath, new_filepath)
    renamed_files << "#{current_date}_#{filename}"
  end
  renamed_files
end

test_dir = File.join(__dir__, "test_folder_task4")
FileUtils.rm_rf(test_dir)
FileUtils.mkdir_p(test_dir)

File.write(File.join(test_dir, "notes.txt"), "Привіт, світ!")
File.write(File.join(test_dir, "report.txt"), "Текстовий звіт")
File.write(File.join(test_dir, "data.doc"), "Не txt файл")

puts "=== Блок 3. Завдання 4 ==="
puts "Файли у тестовій папці до перейменування:"
puts Dir.children(test_dir).inspect

renamed = add_date_to_txt_files(test_dir)
puts "Перейменовані файли (Спосіб 1 з Dir.glob та FileUtils.mv):"
puts renamed.inspect

puts "Файли у папці після перейменування:"
puts Dir.children(test_dir).inspect

FileUtils.rm_rf(test_dir)
