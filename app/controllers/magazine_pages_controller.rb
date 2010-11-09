class MagazinePagesController < ApplicationController
  before_filter :find_magazine , :except => :destroy
  layout "magazines"
  
 # GET /magazine_pages
  # GET /magazine_pages.xm 
  def index
    @magazine_pages = MagazinePage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @magazine_pages }
    end
  end


  # GET /magazine_pages/new
  # GET /magazine_pages/new.xml
  def new
    @magazine_page = MagazinePage.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @magazine_page }
    end
  end

  # GET /magazine_pages/1/edit
  def edit
    @magazine_page = MagazinePage.find(params[:id])
  end

  # POST /magazine_pages
  # POST /magazine_pages.xml
  def create
    @magazine_page = MagazinePage.new(params[:magazine_page])
    respond_to do |format|
      if @magazine_page.save!
        flash[:notice] = 'MagazinePage was successfully created.'
        format.html { redirect_to magazine_url (@magazine) }
        format.xml  { render :xml => @magazine_page, :status => :created, :location => @magazine_page }
      else
        format.html { render :action => "add_pages" }
        format.xml  { render :xml => @magazine_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /magazine_pages/1
  # PUT /magazine_pages/1.xml
  def update
    @magazine_page = MagazinePage.find(params[:id])

    respond_to do |format|
      if @magazine_page.update_attributes(params[:magazine_page])
        flash[:notice] = 'Magazine Page was successfully updated.'
        format.html { redirect_to magazine_url (@magazine) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @magazine_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /magazine_pages/1
  # DELETE /magazine_pages/1.xml
  def destroy
    @magazine_page = MagazinePage.find(params[:id])
    @magazine_page.destroy

    respond_to do |format|
      format.html { redirect_to(magazines_url) }
      format.xml  { head :ok }
    end
  end


  private
  
  def find_magazine
    puts "recibi #{params[:magazine_id]}"
    @magazine_id = params[:magazine_id]
    return (redirect_to(magazines_url)) unless @magazine_id
    @magazine = Magazine.find(@magazine_id)
  end
  

end
