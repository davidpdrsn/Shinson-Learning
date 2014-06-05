class ExportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

  def new
    @export = Export.new
    @page_title = "Export techniques"
  end

  def show
    category_ids = params[:export][:categories]
    belt_ids = params[:export][:belts]
    techniques = current_user.sorted_techniques.select do |t|
      category_ids.include?(t.category_id.to_s) && belt_ids.include?(t.belt_id.to_s)
    end

    @export = Export.new
    @export.techniques = Grouper.new(techniques).group_by(:belt_pretty_print, :category_name)

    render :show, layout: false
  end
end
