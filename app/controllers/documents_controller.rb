class DocumentsController < ApplicationController
  before_filter :get_user, :login_required
  require_role "Admin"
  respond_to :html, :xml

  def index
    @documents = Document.paginate(:page => params[:page], :order => 'id ASC', :per_page => ITEMS_PER_PAGE)

    respond_with(@documents)
  end

  def show
  end

  def new
    @document = @user.documents.new
    @attachment = Attachment.new

    respond_with(@document)
  end

  def create
    @document = @user.documents.new(params[:document])
    @attachment = @document.attachments.build(params[:attachment])

    respond_to do |format|
      if @document.save
        format.html { redirect_to(user_path(@user), :notice => 'File was successfully Uploaded.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @document = @user.documents.find(params[:id])
  end

  def update
    @document = @user.documents.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        @attachment = @document.attachments.each do |a|
          a.update_attributes(params[:attachment])
        end
        format.html { redirect_to(@user, :notice => 'File was successfully Updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def download
    @document = @user.documents.find(params[:document_id])
  end

private
  def get_user
    @user = User.find(params[:user_id])
  end
end
