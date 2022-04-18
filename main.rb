require  'pry-byebug'

class LinkedList
  attr_accessor :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def append(value)
    if @head.nil?
      @head = value
      @tail = value
    else
      @tail.next_node = value
      @tail = value
    end
  end

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


  def at_index(index)
    count = 0
    current = @head
    loop do
      if nil?
        return 'Empty list'
      elsif index > size- 1
        return 'Out of range index'
      elsif count == index
        return current
      end

      count += 1
      current = current.next_node
    end
  end

  # Return element at index
  def at(index)
    at_index(index).value
  end

  def pop
    return nil if @head.nil?
    popped = @tail.value
    at_index(size - 2).next_node = nil
    @tail = at_index(size - 1)
    popped
  end

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
end

class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
