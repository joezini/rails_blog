# This is so joe can say i love u nattie coirm y/n
class MonthsController < ApplicationController
  def index
  end

  def show
    start_date = Date.civil(2016, params[:id].to_i, 1)
    end_date = Date.civil(2016, params[:id].to_i + 1, 1)
    @articles = Article.where(created_at: start_date...end_date)
    @month = Date::MONTHNAMES[start_date.month]
  end
end
