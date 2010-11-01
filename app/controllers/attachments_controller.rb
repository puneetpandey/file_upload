class AttachmentsController < ApplicationController
  before_filter :get_user_document, :login_required
  require_role "Admin"

  def destroy
		@attachment = @document.attachments.find(params[:id])
		@document.destroy && @attachment.destroy

    respond_to do |format|
      format.html { redirect_to(@user) }
      format.xml { head :ok }
    end
	end

  def download
    @attachment = @document.attachments.find(params[:id])

    send_file @attachment.data.path, :type => @attachment.data_content_type, :disposition => 'attachment', :x_sendfile => true
  end

private
  def get_user_document
    @user = User.find(params[:user_id])
    @document = Document.find(params[:document_id])
  end
end
