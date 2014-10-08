class ExportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

 def new
    @page_title = "Export techniques"
  end

  def show
    filtere = TechniquesFilter.new(
      current_user.sorted_techniques,
      params[:export][:categories],
      params[:export][:belts]
    )

    @techniques = filtere.techniques
    render :show, layout: false
  end
end
