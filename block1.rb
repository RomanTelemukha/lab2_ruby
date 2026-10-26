def task1_control(arr)
  indices = []
  i = 0
  while i < arr.length
    indices << i
    i += 1
  end

  i = 0
  while i < indices.length - 1
    min_pos = i
    j = i + 1
    while j < indices.length
      if arr[indices[j]] < arr[indices[min_pos]]
        min_pos = j
      end
      j += 1
    end
    if min_pos != i
      temp = indices[i]
      indices[i] = indices[min_pos]
      indices[min_pos] = temp
    end
    i += 1
  end
  indices
end

def task1_iterator(arr)
  arr.each_index.sort_by { |i| arr[i] }
end

def task10_control(arr)
  result = []
  i = 1
  while i < arr.length
    if arr[i] < arr[i - 1]
      result << i
    end
    i += 1
  end
  result
end

def task10_iterator(arr)
  (1...arr.length).select { |i| arr[i] < arr[i - 1] }
end

arr1 = [35, 12, 89, 5, 42, 18]
puts "=== Блок 1. Завдання 1 ==="
puts "Вхідний масив: #{arr1.inspect}"
puts "Спосіб 1 (керуючі конструкції): #{task1_control(arr1).inspect}"
puts "Спосіб 2 (ітератори): #{task1_iterator(arr1).inspect}"
puts "Перевірка значень за індексами: #{task1_iterator(arr1).map { |idx| arr1[idx] }.inspect}"
puts

arr2 = [10, 5, 8, 3, 15, 12, 20]
puts "=== Блок 1. Завдання 10 ==="
puts "Вхідний масив: #{arr2.inspect}"
puts "Спосіб 1 (керуючі конструкції): #{task10_control(arr2).inspect}"
puts "Спосіб 2 (ітератори): #{task10_iterator(arr2).inspect}"
puts "Знайдені елементи: #{task10_iterator(arr2).map { |idx| "#{arr2[idx]} (індекс #{idx}) < #{arr2[idx - 1]}" }.join(', ')}"
