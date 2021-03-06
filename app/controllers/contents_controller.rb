class ContentsController < ApplicationController
  before_filter :authenticate!

  before_action :ensure_admin!, only: [:new, :edit, :update, :create, :destroy]
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :set_category

  def index
    @contents = Content.where(category_id: params[:category_id])
  end

  def show
  end

  def new
    @content = Content.new
  end

  def edit
  end

  def create
    @content = Content.new(content_params)
    @content.category = @category

    respond_to do |format|
      if @content.save
        format.html { redirect_to [@category, @content], notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to [@category, @content], notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to [@category, :contents], notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_content
      @content = Content.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def content_params
      params.require(:content).permit(:title, :description, :category_id)
    end
end
