module ApplicationHelper
  def limit_link(text)
    text.length > 20 ? "#{text[0...20]}..." : text
  end
end
