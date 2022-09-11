module LessonHelper
  def tiny_format(text)
    h(text).gsub("\n" , "<br />").html_safe
  end

  def tax_included(price)
    (price * 1.08).floor
  end
end
