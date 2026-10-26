def task6_loop(matrix)
  result = []
  i = 0
  while i < matrix.length
    row = matrix[i]
    is_sorted = true
    j = 0
    while j < row.length - 1
      if row[j] > row[j + 1]
        is_sorted = false
        break
      end
      j += 1
    end
    result << i if is_sorted && row.length > 1
    i += 1
  end
  result
end

def task6_iterator(matrix)
  matrix.each_with_index.select do |row, _|
    row.length > 1 && row.each_cons(2).all? { |a, b| a <= b }
  end.map(&:last)
end

def task7_loop(matrix)
  return 0 if matrix.empty? || matrix[0].empty?
  rows = matrix.length
  cols = matrix[0].length
  product = 1
  c = 0
  while c < cols
    max_val = matrix[0][c]
    r = 1
    while r < rows
      if matrix[r][c] > max_val
        max_val = matrix[r][c]
      end
      r += 1
    end
    product *= max_val
    c += 1
  end
  product
end

def task7_iterator(matrix)
  return 0 if matrix.empty? || matrix[0].empty?
  matrix.transpose.map(&:max).inject(1, :*)
end

matrix1 = [
  [1, 4, 7, 10],
  [5, 2, 8, 1],
  [2, 3, 3, 9],
  [10, 8, 6, 4],
  [3, 8, 15, 22]
]

puts "=== Блок 2. Завдання 6 ==="
puts "Вхідна матриця:"
matrix1.each_with_index { |row, idx| puts "Рядок #{idx}: #{row.inspect}" }
puts
puts "Обґрунтування вибору оператора циклу: використано цикл while з оператором break, що дозволяє перервати перевірку рядка одразу при виявленні першого порушення порядку, заощаджуючи час обчислень."
puts "Спосіб 1 (оператор циклу while): #{task6_loop(matrix1).inspect}"
puts "Спосіб 2 (ітератори each_with_index, all?): #{task6_iterator(matrix1).inspect}"
puts

matrix2 = [
  [3, 7, 2],
  [8, 1, 9],
  [4, 6, 5]
]

puts "=== Блок 2. Завдання 7 ==="
puts "Вхідна матриця:"
matrix2.each_with_index { |row, idx| puts "Рядок #{idx}: #{row.inspect}" }
puts
puts "Обґрунтування вибору оператора циклу: використано вкладені цикли while для прямого проходу по стовпцях за індексами без виділення додаткової пам'яті на транспонування матриці."
puts "Спосіб 1 (оператор циклу while): #{task7_loop(matrix2)}"
puts "Спосіб 2 (ітератори transpose, map, inject): #{task7_iterator(matrix2)}"
col_maxes = matrix2.transpose.map(&:max)
puts "Максимуми по стовпцях: #{col_maxes.inspect}"
puts "Добуток: #{col_maxes.join(' * ')} = #{task7_iterator(matrix2)}"
