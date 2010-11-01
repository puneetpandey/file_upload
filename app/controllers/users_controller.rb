class UsersController < ApplicationController
  before_filter :login_required
  #require_role "SuperAdmin"
  #require_role "Admin", :for => :show
  respond_to :html, :xml

  def index
    @users = User.paginate(:page => params[:page], :order => 'id DESC', :per_page => ITEMS_PER_PAGE)

    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    @documents = @user.documents.paginate(:page => params[:page], :order => 'id ASC', :per_page => ITEMS_PER_PAGE)

    respond_with(@user)
  end

  def new
    @user = User.new

    respond_with(@user)
  end
 
  def create
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      #self.current_user = @user # !! now logged in
      redirect_back_or_default(users_url, :notice => "User has been created successfully.")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
