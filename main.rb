require  'pry-byebug'

class LinkedList
  attr_accessor :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  # Adds an element to the end of the list
  def append(value)
    if @head.nil?
      @head = value
      @tail = value
    else
      @tail.next_node = value
      @tail = value
    end
  end

  # Adds an element to the start of the list
  def prepend(value)
    if @head.nil?
      @head = value
      @tail = value
    else
      value.next_node = @head
      @head = value
    end
  end

  def to_s
    output = ''
    current = @head
    loop do
      if current.nil?
        output += 'nil'
        break
      end
      output += "( #{current.value} ) -> "
      current = current.next_node
    end
    output
  end

  #Return the length of the list
  def size
    output = 0
    current = @head
    loop do
      if current.nil?
        break
      else
        output += 1
        current = current.next_node
      end
    end
    output
  end

  def head_get
    @head.value
  end

  def tail_get
    @tail.value
  end

  # Return the node at the specified index
  def at_index(index)
    count = 0
    current = @head
    loop do
      if nil?
        return 'Empty list'
      elsif index > size - 1
        return 'Out of range index'
      elsif count == index
        return current
      end

      count += 1
      current = current.next_node
    end
  end

  # Return value at node index
  def at(index)
    at_index(index).value
  end

  # Removes last element from the list
  def pop
    return nil if @head.nil?
    popped = @tail.value
    at_index(size - 2).next_node = nil
    @tail = at_index(size - 1)
    popped
  end

  # Removes first element from the list
  def shift
    return nil if @head.nil?
    shifted = @head.value
    if slice(1, size).nil?
      @head = nil
    else
      @head = slice(1, size).at_index(0)
    end
    shifted
  end

  # Returns new LinkedList from index x to y
  def slice(x, y)
    return nil if x == y

    output = LinkedList.new
    loop do
      output.append(Node.new(at_index(x).value))
      x += 1
      break if x == y
    end
    output
  end

  # Merge sorting algorithm
  def sort(list = self)
    sorted = LinkedList.new
    if list.size < 2
      sorted.append(Node.new(list.at_index(0).value))
    else
      left = sort(list.slice(0, list.size / 2))
      right = sort(list.slice(list.size / 2, list.size))
      counter = left.size + right.size
      counter.times do
        if left.size.zero? || right.size.zero?
          sorted += right + left
          break
        end
        if left.at(0) < right.at(0)
          sorted.append(Node.new(left.shift))
        else
          sorted.append(Node.new(right.shift))
        end
      end
    end
    sorted
  end

  def +(other)
    if other.head.nil?
      return self
    elsif head.nil?
      return other
    end
    @tail.next_node = other.at_index(0)
    self
  end

  # Returns true if value is present in the list, otherwise false
  def contains?(value)
    if sort.binary_search(value).nil?
      false
    else
      true
    end
  end

  # Returns the index of the node containing the value
  def find(value)
    count = 0
    current = @head
    loop do
      return 'Empty list' if nil?
      return count if value == current.value

      count += 1
      return nil if count > size - 1

      current = current.next_node
    end
  end

  def insert_at(value, index)
    if index > size - 1
      puts 'Out of range'
      return
    end

    list_right = slice(index, size)
    list_left = slice(0, index)
    list_right.prepend(Node.new(value))
    @head = (list_left + list_right).head
  end

  def remove_at(index)
    if index > size - 1
      puts 'Out of range'
      return
    end

    list_right = slice(index, size)
    list_left = slice(0, index)
    list_right.shift
    @head = (list_left + list_right).head
  end

  protected

  def binary_search(value, start = 0, stop = size - 1)
    list = self
    return (start + stop) / 2 if list.at((start + stop) / 2) == value

    if value < list.at((start + stop) / 2)
      stop = (start + stop) / 2 - 1
    else
      start = (start + stop) / 2 + 1
    end
    return nil if start > stop

    list.binary_search(value, start, stop)
  end
end

class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
