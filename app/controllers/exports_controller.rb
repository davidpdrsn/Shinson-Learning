class ExportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

 def new
    @page_title = "Export techniques"
  end

  def show
    categories = Category.where(id: params[:export][:categories])
    belts = Belt.where(id: params[:export][:belts])

    filtere = TechniquesFilter.new(
      current_user.sorted_techniques,
      categories,
      belts
    )

    @techniques = filtere.techniques
    render :show, layout: false
  end
end
