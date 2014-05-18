class ExportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

  def new
    @export = Export.new
    @page_title = "Export techniques"
  end

  def show
    category_ids = params[:export][:categories]
    belt_ids = params[:export][:belts]
    techniques = current_user.techniques.where category_id: category_ids, belt_id: belt_ids

    @export = Export.new
    @export.techniques = Grouper.new(techniques).group_by(:belt_pretty_print, :category_name)

    render :show, layout: false
  end
end
