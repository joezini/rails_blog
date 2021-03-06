class TagsController < ApplicationController
  before_filter :require_login, except: [:create]

  def show
    @tag = Tag.find(params[:id])
  end

  def index
    @tags = Tag.all.order(:name)
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    flash.notice = "Tag #{@tag.name} Deleted!"

    redirect_to tags_path
  end
end
