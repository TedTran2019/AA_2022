class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary  
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def employee_salary
    0
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss = nil)
    @employees = []
    super
  end

  def bonus(multiplier)
    employee_salary * multiplier
  end

  def employee_salary
    @employees.sum { |employee| employee.employee_salary + employee.salary }
  end
end

ned = Manager.new('Ned', 'Founder', 1_000_000)
darren = Manager.new('Darren', 'TA Manager', 78_000, 'Ned')
shawna = Employee.new('Shawna', 'TA', 12_000, 'Darren')
david = Employee.new('David', 'TA', 10_000, 'Darren')
ned.employees << darren
darren.employees << shawna 
darren.employees << david
p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)