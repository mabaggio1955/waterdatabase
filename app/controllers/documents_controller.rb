class DocumentsController < ApplicationController
  before_filter :authenticate!

  def create
    @content = Content.find(params[:content_id])
    @document = Document.new(document_params)
    @document.content = @content

    respond_to do |format|
      if @document.save
        format.html { redirect_to @content, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { redirect_to @content }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @content = Content.find(params[:content_id])
    @document = Document.find(params[:id])
    @document.destroy
    respond_to do |format|
      format.html { redirect_to @content, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def document_params
      params.require(:document).permit(:file, :file_direct_url)
    end
end
