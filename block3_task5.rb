require 'csv'

def calculate_sales_foreach(input_file, output_file)
  totals = Hash.new(0.0)
  
  CSV.foreach(input_file, headers: true) do |row|
    product = row['Product'].to_s.strip
    price = row['Price'].to_f
    quantity = row['Quantity'].to_f
    totals[product] += price * quantity
  end

  CSV.open(output_file, 'w') do |csv|
    csv << ['Product', 'TotalSales']
    totals.each do |product, total|
      csv << [product, ('%.2f' % total)]
    end
  end
  
  totals
end

def calculate_sales_group_by(input_file, output_file)
  table = CSV.read(input_file, headers: true)
  totals = {}

  table.group_by { |row| row['Product'].to_s.strip }.each do |product, rows|
    sum = rows.sum { |r| r['Price'].to_f * r['Quantity'].to_f }
    totals[product] = sum
  end

  CSV.open(output_file, 'w') do |csv|
    csv << ['Product', 'TotalSales']
    totals.each do |product, total|
      csv << [product, ('%.2f' % total)]
    end
  end

  totals
end

input_file = File.join(__dir__, 'sales.csv')
output_file = File.join(__dir__, 'summary.csv')

sample_data = <<~CSV
  Product,Price,Quantity
  Apple,15.50,10
  Banana,8.00,25
  Orange,20.00,15
  Apple,15.50,20
  Banana,8.00,10
  Orange,20.00,5
  Mango,35.00,8
CSV

File.write(input_file, sample_data)

puts "=== Блок 3. Завдання 5 ==="
puts "Вміст вхідного файлу #{File.basename(input_file)}:"
puts File.read(input_file)
puts

calculate_sales_foreach(input_file, output_file)

puts "Результат у #{File.basename(output_file)} (Спосіб 1 з CSV.foreach):"
puts File.read(output_file)
puts

output_file_alt = File.join(__dir__, 'summary_alt.csv')
calculate_sales_group_by(input_file, output_file_alt)
puts "Результат (Спосіб 2 з group_by):"
puts File.read(output_file_alt)
