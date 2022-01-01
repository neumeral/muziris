module ApplicationHelper
  include Pagy::Frontend
  include Pagy::Backend

  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-danger'
    when :alert then 'alert alert-danger'
    else 'alert alert-info'
    end
  end

  def categories
    categories = @categories.map { |category| [category.name, category.id] }
    categories << ['All', 0]
  end
end
