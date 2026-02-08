# frozen_string_literal: true

class A
  def self.scope(name)
    define_method("generated_#{name}") do
      puts "hello generated #{name}"
    end
  end

  scope :hoge
end

A.new.generated_hoge
