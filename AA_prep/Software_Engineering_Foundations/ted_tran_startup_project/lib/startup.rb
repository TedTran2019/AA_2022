require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    salaries.has_key? title
  end

  def >(startup)
    funding > startup.funding
  end

  def hire(employee_name, title)
    raise 'Invalid title!' unless valid_title?(title)
  
    employees << Employee.new(employee_name, title)
  end

  def size
    employees.length
  end

  def pay_employee(employee)
    cash = salaries[employee.title]
    raise 'Not enough funding' if cash > funding

    employee.pay(cash)
    @funding -= cash
  end

  def payday
    employees.each { |employee| pay_employee(employee) }
  end

  def average_salary
    employees.inject(0) { |sum, employee| sum + salaries[employee.title] } / (employees.length * 1.0)
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(startup)
    @funding += startup.funding
    startup.salaries.each { |title, salary| @salaries[title] = salary unless @salaries.has_key? title}
    employees.concat(startup.employees)
    startup.close
  end
end
